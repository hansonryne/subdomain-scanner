require 'test_helper'

class SubdomainRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subdomain_record = subdomain_records(:one)
  end

  test "should get index" do
    get subdomain_records_url
    assert_response :success
  end

  test "should get new" do
    get new_subdomain_record_url
    assert_response :success
  end

  test "should create subdomain_record" do
    assert_difference('SubdomainRecord.count') do
      post subdomain_records_url, params: { subdomain_record: {  } }
    end

    assert_redirected_to subdomain_record_url(SubdomainRecord.last)
  end

  test "should show subdomain_record" do
    get subdomain_record_url(@subdomain_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_subdomain_record_url(@subdomain_record)
    assert_response :success
  end

  test "should update subdomain_record" do
    patch subdomain_record_url(@subdomain_record), params: { subdomain_record: {  } }
    assert_redirected_to subdomain_record_url(@subdomain_record)
  end

  test "should destroy subdomain_record" do
    assert_difference('SubdomainRecord.count', -1) do
      delete subdomain_record_url(@subdomain_record)
    end

    assert_redirected_to subdomain_records_url
  end
end
