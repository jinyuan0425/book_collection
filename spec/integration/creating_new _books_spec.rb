require 'rails_helper'

RSpec.describe "CreatingBooks", type: :system do
  before do
    driven_by(:rack_test)

    # Configure OmniAuth for testing
    OmniAuth.config.test_mode = true

    # Mock the Google OAuth response
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'admin@example.com',
        name: 'Admin User',
        image: 'https://example.com/avatar.jpg'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })

    # Create an admin in the database
    @admin = Admin.create!(
      email: 'admin@example.com',
      full_name: 'Admin User',
      uid: '123456',
      avatar_url: 'https://example.com/avatar.jpg'
    )
  end

  it 'saves & displays the newly created book' do
    # Simulate OAuth login
    visit '/admins/auth/google_oauth2/callback'

    # Expect to be redirected to the root path after successful login
    expect(page).to have_current_path(root_path)

    expect(page).to have_link("New Book", wait: 10)
    click_on "New Book"

    fill_in 'Title', with: 'The Great Gatsby'
    fill_in 'Author', with: 'F. Scott Fitzgerald'
    fill_in 'Published Date', with: '1925-04-10'
    fill_in 'Price', with: '10.99'

    click_on 'Create Book'

    expect(page).to have_content('The Great Gatsby')
    expect(page).to have_content('F. Scott Fitzgerald')
    expect(page).to have_content('1925-04-10')
    expect(page).to have_content('10.99')

    book = Book.order("id").last
    expect(book.title).to eq('The Great Gatsby')
    expect(book.author).to eq('F. Scott Fitzgerald')
    expect(book.published_date.to_s).to eq('1925-04-10')
    expect(book.price.to_f).to eq(10.99)
  end
end
