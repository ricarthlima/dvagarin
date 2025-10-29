String digitsOnly(String? v) =>
    v == null ? '' : v.replaceAll(RegExp(r'\D'), '');
