CONVECTION_VERSION = "v1.0.0"                                                      

my_formats = {
	:short_date => '%Y-%m-%d',
	:date => '%Y-%m-%d',
	:short_time => "%I:%M%p ",
	:time => "%I:%M%p ",
  :month_year => "%b %Y",
	:long_string_date => "%B %e, %Y",
  :month_day_year_words => "%B %e, %Y",
  :date_and_time => "%B %d, %Y %l:%M %p"		  
}
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(my_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(my_formats)
