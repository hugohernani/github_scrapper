require 'rails_helper'

RSpec.describe Github::DefaultUserScrappingJob, type: :job do
  subject(:job_object){ described_class.new }

  job_args = {
    link_shorten_class: Class, web_scrapper_class: Class,
    user_id: nil, target_url: nil
  }

  let(:scrapping_facade){ instance_double('Github::DefaultUserScrappingFacade', perform: nil) }

  before do
    allow(Github::DefaultUserScrappingFacade).to receive(:new).and_return(scrapping_facade)
  end

  it_behaves_like 'job enqueable', 'default', job_args

  it 'performs DefaultUserScrappingFacade service with provided args' do
    job_object.perform(**job_args)

    expect(Github::DefaultUserScrappingFacade).to have_received(:new)
      .with(
        link_shorten: be_a(job_args[:link_shorten_class]),
        web_scrapper: be_a(job_args[:web_scrapper_class])
      )
    expect(scrapping_facade).to have_received(:perform).with(job_args.slice(:user_id, :target_url))
  end
end
