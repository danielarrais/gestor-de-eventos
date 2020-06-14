require "application_system_test_case"

class CertificateTemplatesTest < ApplicationSystemTestCase
  setup do
    @certificate_template = certificate_templates(:one)
  end

  test "visiting the index" do
    visit certificate_templates_url
    assert_selector "h1", text: "Certificate Templates"
  end

  test "creating a Certificate template" do
    visit certificate_templates_url
    click_on "New Certificate Template"

    fill_in "Body", with: @certificate_template.body
    fill_in "Image", with: @certificate_template.image
    fill_in "Person", with: @certificate_template.person_id
    click_on "Create Certificate template"

    assert_text "Certificate template was successfully created"
    click_on "Back"
  end

  test "updating a Certificate template" do
    visit certificate_templates_url
    click_on "Edit", match: :first

    fill_in "Body", with: @certificate_template.body
    fill_in "Image", with: @certificate_template.image
    fill_in "Person", with: @certificate_template.person_id
    click_on "Update Certificate template"

    assert_text "Certificate template was successfully updated"
    click_on "Back"
  end

  test "destroying a Certificate template" do
    visit certificate_templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Certificate template was successfully destroyed"
  end
end
