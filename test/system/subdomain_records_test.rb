require "application_system_test_case"

class SubdomainRecordsTest < ApplicationSystemTestCase
  setup do
    @subdomain_record = subdomain_records(:one)
  end

  test "visiting the index" do
    visit subdomain_records_url
    assert_selector "h1", text: "Subdomain Records"
  end

  test "creating a Subdomain record" do
    visit subdomain_records_url
    click_on "New Subdomain Record"

    click_on "Create Subdomain record"

    assert_text "Subdomain record was successfully created"
    click_on "Back"
  end

  test "updating a Subdomain record" do
    visit subdomain_records_url
    click_on "Edit", match: :first

    click_on "Update Subdomain record"

    assert_text "Subdomain record was successfully updated"
    click_on "Back"
  end

  test "destroying a Subdomain record" do
    visit subdomain_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subdomain record was successfully destroyed"
  end
end
