# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blacklist, type: :model do
  it { is_expected.to validate_presence_of :ip_address }
end
