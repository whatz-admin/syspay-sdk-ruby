require "spec_helper"
require "json"

describe SyspaySDK::Client do
  it "is initialized with the values set in configuration" do
    expect(subject.syspay_id).to eq(SyspaySDK::Config.config.syspay_id)
    expect(subject.syspay_passphrase).to eq(SyspaySDK::Config.config.syspay_passphrase)
    expect(subject.syspay_base_url).to eq(SyspaySDK::Config.config.syspay_base_url)
  end

  it { is_expected.to respond_to(:syspay_id) }
  it { is_expected.to respond_to(:syspay_passphrase) }
  it { is_expected.to respond_to(:syspay_base_url) }

  describe "#generate_digest_for_auth_header" do
    it { is_expected.not_to respond_to(:generate_digest_for_auth_header) }

    it "returns a digest based on the nonce, timestamp and passphrase passed in as parameters" do
      require "base64"
      require 'digest/sha1'

      nonce = rand()
      timestamp = Time.now.to_i

      result = Base64.strict_encode64(Digest::SHA1.digest("#{nonce}#{timestamp}#{subject.syspay_passphrase}"))

      expect(subject.send :generate_digest_for_auth_header, nonce, timestamp).to eq(result)
    end
  end

  describe "#generate_auth_header" do
    it { is_expected.not_to respond_to(:generate_auth_header) }

    it "returns a properly formatted x-wsse Header" do
      syspay_id = "123abc456def"
      random_number = 123456
      timestamp = 789101112
      nonce = "abcdef"
      b64nonce = "ghijkl"
      digest = "digested"

      expect(Time).to receive_message_chain(:now, :to_i).and_return timestamp
      expect(SyspaySDK::Config.config).to receive(:syspay_id).and_return syspay_id

      expect(subject).to receive(:rand).and_return random_number
      expect(Digest::MD5).to receive(:digest).with(random_number.to_s).and_return nonce
      expect(Base64).to receive(:strict_encode64).with(nonce).and_return b64nonce

      expect(subject).to receive(:generate_digest_for_auth_header).with(nonce, timestamp).and_return digest

      expect(
        subject.send :generate_auth_header
      ).to eq(
        "AuthToken MerchantAPILogin=\"#{syspay_id}\", PasswordDigest=\"#{digest}\", Nonce=\"#{b64nonce}\", Created=\"#{timestamp}\""
      )
    end
  end

  describe "Sending a request" do
    let(:request)         { double :request }
    let(:request_object)  { double :request_object }
    let(:response)        { double :response }

    describe "#request" do
      let(:parsed_response) { double :parsed_response }
      let(:https_object)    { double :https_object }
      let(:http_code)       { 200 }

      before do
        allow(subject).to receive(:build_request_for).and_return request
        allow(subject).to receive(:add_headers_to_request)
        allow(subject).to receive(:get_https_object).and_return https_object
        allow(https_object).to receive(:request).and_return response
        allow(response).to receive(:code).and_return http_code
        allow(subject).to receive(:parse_response).and_return parsed_response
      end

      it "builds a request using the request object" do
        subject.request request_object

        expect(subject).to have_received(:build_request_for).with request_object
      end

      it "adds the headers to the request" do
        subject.request request_object

        expect(subject).to have_received(:add_headers_to_request).with request
      end

      it "retrieves the https object" do
        subject.request request_object

        expect(subject).to have_received(:get_https_object)
      end

      it "sends the request" do
        subject.request request_object

        expect(https_object).to have_received(:request).with request
      end

      describe "When the request succeeds" do
        let(:response)        { double :success_response }

        before do
          allow(response).to receive(:code).and_return 200
        end

        it "returns the parsed reponse" do
          expect(subject.request request_object).to eq(parsed_response)

          expect(subject).to have_received(:parse_response).with request_object, response
        end
      end

      describe "When the request fails" do
        let(:response)        { double :failure_response }

        before do
          allow(response).to receive(:code).and_return 404
          allow(response).to receive(:body).and_return "response_body"
          allow(response).to receive(:[]).and_return "123456"
        end

        it "raises a SyspaySDK::Exceptions::RequestError with the http code and response" do
          begin
            subject.request request_object
          rescue Exception => e
            expect(e).to be_a SyspaySDK::Exceptions::RequestError
            expect(e.instance_variable_get :@http_code).to eq(404)
            expect(e.instance_variable_get :@response_body).to eq("response_body")
            expect(e.instance_variable_get :@uuid).to eq("123456")
          end
        end
      end
    end

    describe "#get_https_object" do
      let(:uri)   { double :uri }
      let(:host)  { double :host }
      let(:port)  { double :port }
      let(:https) { double :https }

      before do
        allow(URI).to receive(:parse).and_return uri
        allow(uri).to receive(:host).and_return host
        allow(uri).to receive(:port).and_return port
        allow(Net::HTTP).to receive(:new).and_return https
        allow(https).to receive(:use_ssl=)
      end

      it { is_expected.not_to respond_to(:get_https_object) }

      it "creates an URI from syspay_base_url" do
        subject.send :get_https_object

        expect(URI).to have_received(:parse).with subject.syspay_base_url
      end

      it "creates an http object using that uri" do
        subject.send :get_https_object

        expect(Net::HTTP).to have_received(:new).with(host, port)
      end

      it "enables ssl on the http object" do
        subject.send :get_https_object

        expect(https).to have_received(:use_ssl=).with true
      end

      it "returns the http object" do
        expect(subject.send :get_https_object).to eq(https)
      end
    end

    describe "#parse_response" do
      let(:body)            { double :body }
      let(:code)            { double :code }
      let(:data)            { double :data }
      let(:response_object) { double :response_object }

      let(:decoded_body) do
        {
          data: data
        }
      end

      before do
        allow(response).to receive(:body).and_return body
        allow(response).to receive(:code).and_return code
        allow(JSON).to receive(:parse).and_return decoded_body
        allow(request_object).to receive(:build_response).and_return response_object
        allow(request_object).to receive(:get_data).and_return data
      end

      it { is_expected.not_to respond_to(:parse_response) }

      it "decodes the body using JSON" do
        subject.send :parse_response, request_object, response
        expect(JSON).to have_received(:parse).with body
      end

      it "builds the response object and returns it" do
        expect(subject.send :parse_response, request_object, response).to eq({
          response_object:  response_object,
          request_data:     data,
          response_data:    body,
          response_code:    code
        })

        expect(request_object).to have_received(:build_response).with data
      end
    end

    describe "#add_headers_to_request" do
      let(:auth_header) { double :auth_header }

      before do
        allow(subject).to receive(:generate_auth_header).and_return auth_header
        allow(request).to receive(:[]=)
      end

      it { is_expected.not_to respond_to(:add_headers_to_request) }

      it "sets the 'Accept' header" do
        subject.send :add_headers_to_request, request

        expect(request).to have_received(:[]=).with('Accept', "application/json")
      end

      it "sets the 'X-Wsse' header" do
        subject.send :add_headers_to_request, request

        expect(request).to have_received(:[]=).with('X-Wsse', auth_header)
      end

      it "sets the 'Content-Type' header" do
        subject.send :add_headers_to_request, request

        expect(request).to have_received(:[]=).with('Content-Type', "application/json")
      end
    end

    describe "#build_request_for" do
      let(:path)        { double :path }
      let(:data)        { double :data }
      let(:query_data)  { double :query_data }
      let(:json_data)   { double :json_data }

      before do
        allow(request_object).to receive(:get_path).and_return path
        allow(request_object).to receive(:get_data).and_return data
        allow(data).to receive(:to_query).and_return query_data
        allow(data).to receive(:to_json).and_return json_data
      end

      it { is_expected.not_to respond_to(:build_request_for) }

      describe "When request method is 'GET'" do
        let(:get_request) { double :get_request }

        before do
          allow(request_object).to receive_message_chain(:get_method, :upcase).and_return 'GET'
          allow(Net::HTTP::Get).to receive(:new).and_return get_request
        end

        it "builds a GET request object with the request_object path and data" do
          expect(subject.send :build_request_for, request_object).to eq get_request
          expect(Net::HTTP::Get).to have_received(:new).with("#{path}?#{query_data}")
        end
      end

      describe "When request method is 'PUT'" do
        let(:put_request) { double :put_request }

        before do
          allow(request_object).to receive_message_chain(:get_method, :upcase).and_return 'PUT'
          allow(Net::HTTP::Put).to receive(:new).and_return put_request
          allow(put_request).to receive(:body=)
        end

        it "builds a PUT request object with the request_object path" do
          expect(subject.send :build_request_for, request_object).to eq put_request
          expect(put_request).to have_received(:body=).with(json_data)
          expect(Net::HTTP::Put).to have_received(:new).with(path)
        end
      end

      describe "When request method is 'POST'" do
        let(:post_request) { double :post_request }

        before do
          allow(request_object).to receive_message_chain(:get_method, :upcase).and_return 'POST'
          allow(Net::HTTP::Post).to receive(:new).and_return post_request
          allow(post_request).to receive(:body=)
        end

        it "builds a POST request object with the request_object path" do
          expect(subject.send :build_request_for, request_object).to eq post_request
          expect(post_request).to have_received(:body=).with(json_data)
          expect(Net::HTTP::Post).to have_received(:new).with(path)
        end
      end

      describe "When request method is not handled" do
        it "raises a SyspaySDK::Exceptions::UnhandledMethodError" do
          allow(request_object).to receive_message_chain(:get_method, :upcase).and_return 'DELETE'

          expect {
            subject.send :build_request_for, request_object
          }.to raise_error SyspaySDK::Exceptions::UnhandledMethodError
        end
      end
    end
  end
end