require 'test_helper'

class CertificateTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate_template = certificate_templates(:one)
  end

  test "should get index" do
    get certificate_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_certificate_template_url
    assert_response :success
  end

  test "should create certificate_template" do
    assert_difference('CertificateTemplate.count') do
      post certificate_templates_url, params: { certificate_template: { body: @certificate_template.body, image: @certificate_template.image, person_id: @certificate_template.person_id } }
    end

    assert_redirected_to certificate_template_url(CertificateTemplate.last)
  end

  test "should show certificate_template" do
    get certificate_template_url(@certificate_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_certificate_template_url(@certificate_template)
    assert_response :success
  end

  test "should update certificate_template" do
    patch certificate_template_url(@certificate_template), params: { certificate_template: { body: @certificate_template.body, image: @certificate_template.image, person_id: @certificate_template.person_id } }
    assert_redirected_to certificate_template_url(@certificate_template)
  end

  test "should destroy certificate_template" do
    assert_difference('CertificateTemplate.count', -1) do
      delete certificate_template_url(@certificate_template)
    end

    assert_redirected_to certificate_templates_url
  end
end
