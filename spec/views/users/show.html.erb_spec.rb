# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    assign(:user, User.create!(
                    username: 'Username'
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Username/)
  end
end
