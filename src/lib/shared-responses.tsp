import "@typespec/http";

using TypeSpec.Http;

namespace SharedResponses;

@doc("Http 200 Success. The request has succeeded.")
model SuccessResponse {
    @statusCode _: 200;
    @header contentType: "text/html";
    @body body: "OK";
}

@doc("Http 200 Success. It happenes when the request is invalid.")
model FailureResponse {
    @statusCode _: 200;
    @header contentType: "text/html";
    @body body: "FAIL";
}

@doc("Http 404 Error. The endpoints raises 404 error if no value is unset by another endpoints. (The devices seems have no default value.)")
model NoDataResponse {
    @statusCode _: 404;
}