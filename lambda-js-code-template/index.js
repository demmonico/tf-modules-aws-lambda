// Just empty initial lambda function for created resources
exports.handler = async (event, ctx) => {
    const msg = 'Hello from the dummy lambda!';
    console.log(msg, event, ctx);

    const respBody = { message: msg }
    const { version } = event;
    const resp = version === '2.0' ? { ...respBody } : {
        statusCode: 200,
        body: JSON.stringify(respBody)
    };
    console.log(version, respBody, resp);

    return resp;
}
