# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminText, type: :model do
  let(:admin_text) do
    AdminText.new(field: 'terms_of_use', text: 'foobar')
  end

  it { is_expected.to validate_presence_of :field }
  it { is_expected.to validate_presence_of :text }

  describe '#as_json' do
    subject { admin_text.as_json }

    let(:expected_hash) do
      {
        id: admin_text.id,
        field: admin_text.field,
        text: admin_text.text
      }
    end

    it { is_expected.to eq(expected_hash) }
  end
end
