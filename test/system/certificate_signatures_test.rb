require "application_system_test_case"

class CertificateSignaturesTest < ApplicationSystemTestCase
  setup do
    @certificate_signature = certificate_signatures(:one)
  end

  test "visiting the index" do
    visit certificate_signatures_url
    assert_selector "h1", text: "Certificate Signatures"
  end

  test "creating a Certificate signature" do
    visit certificate_signatures_url
    click_on "New Certificate Signature"

    click_on "Create Certificate signature"

    assert_text "Certificate signature was successfully created"
    click_on "Back"
  end

  test "updating a Certificate signature" do
    visit certificate_signatures_url
    click_on "Edit", match: :first

    click_on "Update Certificate signature"

    assert_text "Certificate signature was successfully updated"
    click_on "Back"
  end

  test "destroying a Certificate signature" do
    visit certificate_signatures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Certificate signature was successfully destroyed"
  end
end
