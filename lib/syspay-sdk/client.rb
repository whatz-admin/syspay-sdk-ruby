require "base64"
require 'digest'

module Syspay
  module SDK
    class Client
      attr_accessor :syspay_id, :syspay_passphrase, :syspay_base_url, :response_body, :response_headers, :response_data, :request_body, :request_headers, :request_params, :request_id

      def initialize
        self.syspay_id = Syspay::SDK::Config.config.syspay_id
        self.syspay_passphrase = Syspay::SDK::Config.config.syspay_passphrase
        self.syspay_base_url = Syspay::SDK::Config.config.syspay_base_url
      end

      # Generates the x-wsse header
      def generate_auth_header
        timestamp = Time.now.to_i

        nonce = Digest::MD5.hexdigest(rand().to_s)
        b64nonce = Base64.strict_encode64(nonce)

        digest = generate_digest_for_auth_header(nonce, timestamp, self.syspay_passphrase)

        "AuthToken MerchantAPILogin='#{self.syspay_id}', PasswordDigest='#{digest}', Nonce='#{nonce}', Created='#{timestamp}'"
      end

      def generate_digest_for_auth_header nonce, timestamp, passphrase
        Base64.strict_encode64(Digest::SHA1.hexdigest("#{nonce}#{timestamp}#{passphrase}"))
      end
    end
  end
end

#     /**
#      * Make a request to the Syspay API
#      * @param Syspay_Merchant_Request $request The request to send to the API
#      *
#      * @return mixed The response to the request
#      * @throws Syspay_Merchant_RequestException If the request could not be processed by the API
#      */
#     public function request(Syspay_Merchant_Request $request)
#     {
#         $this->requestBody = $this->responseBody = $this->responseData = $this->requestId = null;
#         $this->responseHeaders = $this->requestHeaders = array();
#         $headers = array(
#             'Accept: application/json',
#             'X-Wsse: ' . $this->generateAuthHeader($this->username, $this->secret)
#         );
#         $url = rtrim($this->baseUrl, '/') . '/' . ltrim($request->getPath(), '/');
#         $ch = curl_init();
#         curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
#         curl_setopt($ch, CURLOPT_HEADER, true);
#         curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); // TODO: verify ssl and provide certificate in package
#         curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
#         $method = strtoupper($request->getMethod());
#         // Per-method special handling
#         switch($method) {
#             case 'PUT':
#             case 'POST':
#                 $body = json_encode($request->getData());
#                 array_push($headers, 'Content-Type: application/json');
#                 array_push($headers, 'Content-Length: ' . strlen($body));
#                 curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
#                 $this->requestBody = $body;
#                 break;
#             case 'GET':
#                 $queryParams = $request->getData();
#                 if (is_array($queryParams)) {
#                     $url .= '?' . http_build_query($queryParams);
#                 }
#                 $this->requestParams = $queryParams;
#                 break;
#             case 'DELETE':
#                 break;
#             default:
#                 throw new Exception('Unsupported method given: ' . $method);
#         }
#         curl_setopt($ch, CURLOPT_URL, $url);
#         curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
#         curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
#         $this->requestHeaders = $headers;
#         $response = curl_exec($ch);
#         if ($response === false) {
#             throw new Exception(curl_error($ch), curl_errno($ch));
#         }
#         $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
#         list($headers, $body) = explode("\r\n\r\n", $response, 2);
#         $this->responseHeaders = explode("\r\n", $headers);
#         $this->responseBody    = $body;
#         if (preg_match('/\nx-syspay-request-uuid: (.*?)\r?\n/i', $headers, $m)) {
#             $this->requestId = $m[1];
#         }
#         if (!in_array($httpCode, array(200, 201))) {
#             throw new Syspay_Merchant_RequestException($httpCode, $headers, $body);
#         }
#         $decoded = json_decode($body);
#         if (($decoded instanceof stdClass) && isset($decoded->data) && ($decoded->data instanceof stdClass)) {
#             $this->responseData = $decoded->data;
#             return $request->buildResponse($decoded->data);
#         } else {
#             throw new Syspay_Merchant_UnexpectedResponseException('Unable to decode response from json', $body);
#         }
#         return false;
#     }
