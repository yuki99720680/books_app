require 'rails_helper'

RSpec.describe 'Books', type: :system do
  before do
    FactoryBot.create(:book)
  end

  scenario 'プロジェクトの一覧を閲覧する' do
    visit books_path

    expect(page).to have_content 'Test Book'
    expect(page).to have_content 'Trying out Capybara'
    expect(page).to have_content 'm-kimura'
    expect(page).to have_content '/uploads_test/book/picture/1/test.png'
  end

  scenario 'プロジェクトの詳細を閲覧する' do
    visit books_path
    click_link 'Show'

    expect(page).to have_content 'Test Book'
    expect(page).to have_content 'Trying out Capybara'
    expect(page).to have_content 'm-kimura'
    expect(page).to have_selector "img[src$='test.png']"
  end

  scenario '新しいプロジェクトを作成する' do
    visit books_path
    content = {
      title: 'Test Book',
      memo: 'Trying out Capybara',
      author: 'm-kimura'
    }

    expect {
      click_link 'New Book'
      fill_in 'Title', with: content[:title]
      fill_in 'Memo', with: content[:memo]
      fill_in 'Author', with: content[:author]
      attach_file 'Picture', "#{Rails.root}/spec/files/test.png"
      click_button 'Create Book'
    }.to change(Book, :count).by(1)
    expect(page).to have_content 'Book was successfully created'
    expect(page).to have_content content[:title]
    expect(page).to have_content content[:memo]
    expect(page).to have_content content[:author]
    expect(page).to have_selector "img[src$='test.png']"
  end

  scenario 'プロジェクトを編集する' do
    visit books_path
    click_link 'Edit'
    content = {
      title: 'Test Book Chan',
      memo: 'Trying out Capybara Kun',
      author: 'Im m-kimura'
    }
    fill_in 'Title', with: content[:title]
    fill_in 'Memo', with: content[:memo]
    fill_in 'Author', with: content[:author]
    attach_file 'Picture', "#{Rails.root}/spec/files/test2.png"
    click_button 'Update Book'

    expect(page).to have_content 'Book was successfully updated'
    expect(page).to have_content content[:title]
    expect(page).to have_content content[:memo]
    expect(page).to have_content content[:author]
    expect(page).to have_selector "img[src$='test2.png']"
  end

  scenario 'プロジェクトを削除する', js: true do
    visit books_path

    expect {
      click_link 'Destroy'
      expect(page.accept_confirm).to eq 'Are you sure?'
      expect(page).to have_content 'Book was successfully destroyed'
    }.to change(Book, :count).by(-1)
  end
end
