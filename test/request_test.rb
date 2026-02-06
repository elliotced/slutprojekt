require_relative 'spec_helper'
require_relative '../lib/request'

class RequestTest < Minitest::Test

  def test_parses_http_method
    # test from get-index
    request_string = File.read('fake-requests/get-index.request.txt')
    request = Request.new(request_string)
    assert_equal 'GET', request.method

    # test from get-fruits-with-filter
    request_string = File.read('fake-requests/get-fruits-with-filter.request.txt')
    request = Request.new(request_string)
    assert_equal 'GET', request.method
  end

  def test_parses_resource_from_simple_get
    # test from get-index
    request_string = File.read('fake-requests/get-index.request.txt')
    request = Request.new(request_string)
    assert_equal '/', request.resource

    # test from get-fruits-with-filter
    request_string = File.read('fake-requests/get-fruits-with-filter.request.txt')
    request = Request.new(request_string)
    assert_equal '/fruits', request.resource
  end

  def test_parses_version_from_simple_get
    # test from get-index
    request_string = File.read('fake-requests/get-index.request.txt')
    request = Request.new(request_string)
    assert_equal 'HTTP/1.1', request.version

    # test from get-fruits-with-filter
    request_string = File.read('fake-requests/get-fruits-with-filter.request.txt')
    request = Request.new(request_string)
    assert_equal 'HTTP/1.1', request.version
  end

  def test_parses_params_from_simple_get
    # test from get-index
    request_string = File.read('fake-requests/get-index.request.txt')
    request = Request.new(request_string)
    empty_hash = {}
    assert_equal empty_hash, request.params

    # test from get-fruits-with-filter
    request_string = File.read('fake-requests/get-fruits-with-filter.request.txt')
    request = Request.new(request_string)
    params_hash = {"type" => "bananas", "minrating" => "4"}
    assert_equal params_hash, request.params
  end

  def test_parses_headers_from_simple_get
    # test from get-index
    request_string = File.read('fake-requests/get-index.request.txt')
    request = Request.new(request_string)
    header_hash = {"Host" => "developer.mozilla.org", "Accept-Language" => "fr"}
    assert_equal header_hash, request.headers

    # test from get-fruits-with-filter
    request_string = File.read('fake-requests/get-fruits-with-filter.request.txt')
    request = Request.new(request_string)
    header_hash = {"Host" => "fruits.com", "User-Agent" => "ExampleBrowser/1.0", "Accept-Encoding" => "gzip, deflate", "Accept" => "*/*"}
    assert_equal header_hash, request.headers
  end

end