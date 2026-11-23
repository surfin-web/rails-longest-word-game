require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert_text "New game"
    assert_selector "li", count: 10
  end

  test "Filling a word that is not in the grid gives an error message" do
    visit new_url
    fill_in "word", with: "EXTRAORDINARY"
    click_on "Play"
    assert_text "can't be built out of"
  end

  test "Filling a word that is not English gives a not English word message" do
    visit new_url
    page.execute_script("document.querySelector('input[name=letters]').value = 'QXZJKVBWFG'")
    fill_in "word", with: "QXZ"
    click_on "Play"
    assert_text "does not seem to be a valid English word"
  end

  test "Filling a valid English word gives a congratulations message" do
    visit new_url
    page.execute_script("document.querySelector('input[name=letters]').value = 'DUNEXXXXXX'")
    fill_in "word", with: "DUNE"
    click_on "Play"
    assert_text "Congratulations!"
  end
end
