class Address {
  final int? id;
  final int? zip_code;
  final String? address;
  final String? city;
  final String? state;

  Address({
    this.id,
    this.zip_code,
    this.address,
    this.city,
    this.state,
  });

  factory Address.fromJson(Map<String?, dynamic> json) {
    return Address(
      id: json['id'] as int?,
      zip_code: json['zip_code'] as int?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
    );
  }
}

class Email {
  final int? id;
  final String? email;
  final String? phone;
  Email({
    this.id,
    this.email,
    this.phone,
  });

  factory Email.fromJson(Map<String?, dynamic> json) {
    return Email(
      id: json['id'] as int?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }
}

class Experience {
  final int? id;
  final String? status;
  final String? job_title;
  final String? company_name;
  final String? industry;
  Experience({
    this.id,
    this.status,
    this.job_title,
    this.company_name,
    this.industry,
  });

  factory Experience.fromJson(Map<String?, dynamic> json) {
    return Experience(
      id: json['id'] as int?,
      status: json['status'] as String?,
      job_title: json['job_title'] as String?,
      company_name: json['company_name'] as String?,
      industry: json['industry'] as String?,
    );
  }
}
