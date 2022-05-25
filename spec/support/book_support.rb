module BookSupport
  def expect_page_to_have_content_as_factory
    expect(page).to have_content 'Test Book'
    expect(page).to have_content 'Trying out Capybara'
    expect(page).to have_content 'm-kimura'
  end

  def expect_page_to_have_content(content)
    expect(page).to have_content content[:title]
    expect(page).to have_content content[:memo]
    expect(page).to have_content content[:author]
  end

  def fill_in_content(content)
    fill_in 'Title', with: content[:title]
    fill_in 'Memo', with: content[:memo]
    fill_in 'Author', with: content[:author]
  end
end
