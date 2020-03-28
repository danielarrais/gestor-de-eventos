require 'test_helper'

class CertificateSignaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate_signature = certificate_signatures(:one)
  end

  test "should get index" do
    get certificate_signatures_url
    assert_response :success
  end

  test "should get new" do
    get new_certificate_signature_url
    assert_response :success
  end

  test "should create certificate_signature" do
    assert_difference('CertificateSignature.count') do
      post certificate_signatures_url, params: { certificate_signature: {  } }
    end

    assert_redirected_to certificate_signature_url(CertificateSignature.last)
  end

  test "should show certificate_signature" do
    get certificate_signature_url(@certificate_signature)
    assert_response :success
  end

  test "should get edit" do
    get edit_certificate_signature_url(@certificate_signature)
    assert_response :success
  end

  test "should update certificate_signature" do
    patch certificate_signature_url(@certificate_signature), params: { certificate_signature: {  } }
    assert_redirected_to certificate_signature_url(@certificate_signature)
  end

  test "should destroy certificate_signature" do
    assert_difference('CertificateSignature.count', -1) do
      delete certificate_signature_url(@certificate_signature)
    end

    assert_redirected_to certificate_signatures_url
  end
end
