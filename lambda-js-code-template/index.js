// Just empty initial lambda function for created resources
exports.handler = (event, ctx) => {
    const msg = 'Hello, world!';
    console.log(msg, event, ctx);
    return msg;
}
