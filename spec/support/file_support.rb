module FileSupport
  def update_picture(filename)
    visit books_path
    click_link 'Edit'
    attach_file 'Picture', "#{Rails.root}/spec/files/#{filename}"
    click_button 'Update Book'
  end
end
