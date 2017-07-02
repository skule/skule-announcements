ActionMailer::Base.smtp_settings = {
	:address			=> "smtp.example.com",
	:port				=> 587,
	:domain				=> "example.com",
	:user_name				=> "jsmith",
	:password				=> "foobar",
	:authentication			=> "plain",
	:enable_starttle_auto 	=> true

}