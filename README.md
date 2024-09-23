# GeekMagic OpenApi

![TypeSpec logo](https://img.shields.io/badge/Language-TypeSpec-8A2BE2?style=flat-square)
![OpenAPI 3.0 logo](https://img.shields.io/badge/Docs-OpenAPI%203.0-success?style=flat-square)

Unofficial GeekMagic OpenApi document written in [TypeSpec](https://typespec.io/).
Researched on [Geekmagic-smalltv](https://aliexpress.com/item/1005006159850972.html) but it should be works for other devices.

## How to use

### Build result
- [OpenAPI document](https://github.com/Dosugamea/geekmagic-openapi/blob/main/docs/openapi.yaml)
  - For use with client generators
- [API reference web page (by redocly)](https://dosugamea.github.io/geekmagic-openapi/openapi.html)
  - For read the api specs


## How to build
In case you want to build yourself, please follow below things.

### Requirements
- Node.js > 20
- pnpm

### Commands
```
pnpm install
pnpm run build:tsp
pnpm run build:docs
```

## License
MIT

## Maintainer
Dosugamea

## Related references
- TypeSpec が OpenAPI や JSON Schema を書くのに良かったので紹介する
  - https://zenn.dev/kimuson/articles/typespec_openapi
- OpenAPIドキュメントを書いて作って公開する
  - https://zenn.dev/robon/articles/c72deed4632b9d
- TypeScript のような構文で OpenAPI のスキーマを定義する TypeSpec
  - https://azukiazusa.dev/blog/typescript-like-syntax-for-openapi-schemas/
