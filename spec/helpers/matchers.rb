RSpec::Matchers.define :be_a_uuid do
  uuid = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/
  match do |actual|
     expect(actual).to match_regex(uuid)
  end

  failure_message do |actual|
    "expected that #{actual} matches the uuid pattern: #{uuid}"
  end
end