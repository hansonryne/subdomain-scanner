require "application_system_test_case"

class ScansTest < ApplicationSystemTestCase
  setup do
    @scan = scans(:one)
  end

  test "visiting the index" do
    visit scans_url
    assert_selector "h1", text: "Scans"
  end

  test "creating a Scan" do
    visit scans_url
    click_on "New Scan"

    click_on "Create Scan"

    assert_text "Scan was successfully created"
    click_on "Back"
  end

  test "updating a Scan" do
    visit scans_url
    click_on "Edit", match: :first

    click_on "Update Scan"

    assert_text "Scan was successfully updated"
    click_on "Back"
  end

  test "destroying a Scan" do
    visit scans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scan was successfully destroyed"
  end
end
