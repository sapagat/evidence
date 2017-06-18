require 'uri'

RSpec::Matchers.define :be_an_s3_presigned_url do
  match do |candidate|
    uri = URI.parse(candidate)
    expect(uri.host).to include('amazon')
    expect(uri.host).to include('a_region')
    expect(uri.request_uri).to include('a_bucket')
    expect(uri.request_uri).to include(
      'X-Amz-Algorithm',
      'X-Amz-Credential',
      'X-Amz-Date',
      'X-Amz-Expires',
      'X-Amz-SignedHeaders',
      'X-Amz-Signature'
    )
  end

  failure_message do |actual|
    "expected that #{actual} would be an s3 pre-signed url"
  end
end