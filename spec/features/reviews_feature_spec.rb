require 'rails_helper'

feature 'reviewing' do

  context 'user is signed in' do

    before do
      user = build :user
      sign_up(user)
    end

    scenario 'allows users to leave a review using a form' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'can only leave one review per restaurant' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'can only delete restaurant user create' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_link 'Delete KFC'
    end

    scenario 'can only delete restaurant user create' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Sign out'
      user = build :user2
      sign_up(user)
      expect(page).not_to have_link 'Delete KFC'
    end

    scenario 'can delete review' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_content 'Delete review'
    end

    scenario 'displays an average rating for all reviews' do
      visit '/restaurants'
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      leave_review('So so', '3')
      click_link 'Sign out'
      user = build :user2
      sign_up(user)
      leave_review('Great', '5')
      expect(page).to have_content('Average rating: ★★★★☆')
    end

  end

end

def leave_review(thoughts, rating)
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
