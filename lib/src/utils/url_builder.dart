class UrlBuilder {
  final String baseUrl;
  final Map<String, String> _queryParams = {};

  UrlBuilder(this.baseUrl);

  UrlBuilder addQueryParam(String key, String value) {
    _queryParams[key] = value;
    return this;
  }

  UrlBuilder removeQueryParam(String key) {
    _queryParams.remove(key);
    return this;
  }

  String build() {
    if (_queryParams.isEmpty) {
      return baseUrl;
    }

    final queryString = _queryParams.entries
        .map((entry) => '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}')
        .join('&');

    return '$baseUrl?$queryString';
  }
}
