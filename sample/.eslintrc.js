module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2018,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "max-len": [
      "error",
      {
        "code": 100,
        "ignoreComments": true,
        "ignoreUrls": true,
      },
    ],
    "linebreak-style": "off",
    "no-unused-vars": "off",
    "quotes": "off",
    "object-curly-spacing": "off",
    "indent": "off",
    "padded-blocks": "off",
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    // "quotes": ["error", "double", {"allowTemplateLiterals": true}],
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
