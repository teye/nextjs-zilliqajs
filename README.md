# nextjs-zilliqajs
This repo is used to test a nextjs sample project and see the effects when we installed a zilliqajs module and run the nextjs project on docker.


## Steps

1. Create sample nextjs project: https://nextjs.org/learn/basics/create-nextjs-app/setup

2. Install zilliqajs

```bash
npm i @zilliqa-js/zilliqa
```

3. Import zilliqajs into `pages/index.js`
```javascript
const { Zilliqa } = require('@zilliqa-js/zilliqa');
```

4. Add `./next.config.js` in `serverless mode`:
```
module.exports = {
    target: 'serverless'
}
```

5. Build docker image and observe failure logs.
```bash
docker build -t nextjs-docker .
```

### Logs

```bash
$ next build
warn  - The `target` config is deprecated and will be removed in a future version.
See more info here https://nextjs.org/docs/messages/deprecated-target-config
Attention: Next.js now collects completely anonymous telemetry regarding usage.
This information is used to shape Next.js' roadmap and prioritize features.
You can learn more, including how to opt-out if you'd not like to participate in this anonymous program, by visiting the following URL:
https://nextjs.org/telemetry

info  - Checking validity of types...
warn  - No ESLint configuration detected. Run next lint to begin setup
info  - Creating an optimized production build...
warn  - Compiled with warnings

./node_modules/node-fetch/lib/index.js
Module not found: Can't resolve 'encoding' in '/usr/src/app/node_modules/node-fetch/lib'

Import trace for requested module:
./node_modules/cross-fetch/dist/node-ponyfill.js
./node_modules/cross-fetch/dist/node-polyfill.js
./node_modules/@zilliqa-js/core/dist/net.js
./node_modules/@zilliqa-js/core/dist/index.js
./node_modules/@zilliqa-js/zilliqa/dist/index.js
./pages/index.js
./node_modules/next/dist/build/webpack/loaders/next-serverless-loader/index.js?page=%2F&absolutePagePath=private-next-pages%2Findex.js&absoluteAppPath=next%2Fdist%2Fpages%2F_app&absoluteDocumentPath=next%2Fdist%2Fpages%2F_document&absoluteErrorPath=next%2Fdist%2Fpages%2F_error&absolute404Path=&distDir=private-dot-next&buildId=e95RkZMIBYknUwb-WY1YY&assetPrefix=&generateEtags=true&poweredByHeader=true&canonicalBase=&basePath=&runtimeConfig=&previewProps=%7B%22previewModeId%22%3A%22862cfed180ff308a17b6c026de9f19f3%22%2C%22previewModeSigningKey%22%3A%2220dba7cc434ba9e83257c577fb810183d03f3b5d3efd07182216133a775f5f27%22%2C%22previewModeEncryptionKey%22%3A%229cf312d96c7dab6b0a4d78c2292d5e3a93c0fded9a4b75478074710f9418c4ab%22%7D&loadedEnvFiles=W10%3D&i18n=!

info  - Collecting page data...

> Build error occurred
Error: No native build was found for platform=linux arch=x64 runtime=node abi=83 uv=1 libc=glibc node=14.16.1 webpack=true
    loaded from: /usr/src/app/.next/serverless/chunks

    at Function.load.path (/usr/src/app/.next/serverless/chunks/685.js:22546:9)
    at load (/usr/src/app/.next/serverless/chunks/685.js:22508:30)
    at Object.5530 (/usr/src/app/.next/serverless/chunks/685.js:26359:39)
    at __webpack_require__ (/usr/src/app/.next/serverless/webpack-runtime.js:25:43)
    at Object.8269 (/usr/src/app/.next/serverless/chunks/685.js:26375:41)
    at __webpack_require__ (/usr/src/app/.next/serverless/webpack-runtime.js:25:43)
    at Object.3511 (/usr/src/app/.next/serverless/chunks/685.js:4493:55)
    at __webpack_require__ (/usr/src/app/.next/serverless/webpack-runtime.js:25:43)
    at Object.7053 (/usr/src/app/.next/serverless/chunks/685.js:4535:16)
    at __webpack_require__ (/usr/src/app/.next/serverless/webpack-runtime.js:25:43) {
  type: 'Error'
}
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
The command '/bin/sh -c yarn run build' returned a non-zero code: 1
```

## Observations

If we use nextjs in `serverless` mode and configure the webpack to resolve the `fs`. We will encounter build errors in docker if we also import zilliqa-js >= 3.3.2. However, if we hardcode zilliqa-js to <= 3.3.1, then there would not be any build errors.

## Solution
NextJS has deprecated `target` options in their latest NextJS. See https://nextjs.org/docs/upgrading#target-option-deprecated and https://nextjs.org/docs/advanced-features/output-file-tracing. As per NextJS documentation: "_Furthermore, this removes the need for the deprecated serverless target which can cause various issues and also creates unnecessary duplication._". It is therefore recommended for anyone using NextJS with ZilliqaJS to update their NextJS version and omit the deprecated `target` options.
