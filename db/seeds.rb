# frozen_string_literal: true

# for_development_environment
# User.create([
#               name: ENV['ADMIN_NAME'],
#               provider: 'github',
#               uid: ENV['ADMIN_UID'],
#               image: ENV['ADMIN_IMAGE'],
#               admin: true
#             ])

module_names = %w[Enumerable Array Hash String Numeric Range]

module_names.each do |module_name|
  RubyModule.create([
                      name: module_name
                    ])
end

ruby_module_ids = RubyModule.all.order(id: 'ASC').pluck(:id)

# rubocop:disable Layout/LineLength
enumerables = %w[collect_concat each_slice each_with_object entries filter_map find find_all flat_map grep grep_v group_by inject max_by min_by minmax minmax_by partition reduce reject slice_after slice_before slice_when sort_by take take_while tally]

arrays = %w[append assoc at clear clone collect compact concat count delete delete_at delete_if difference dig drop drop_while dup fetch fill filter find_index flatten hash index insert intersection join keep_if max min minmax pop prepend product push reject replace rindex rotate sample select shift shuffle size slice sort sum take take_while transpose union uniq unshift values_at]

hashs = %w[assoc clear clone compact delete delete_if dig dup except fetch fetch_values filter flatten invert keep_if key keys length merge rehash reject replace select shift size slice store transform_keys transform_values update values values_at]

strings = %w[byteindex capitalize casecmp center chars chr concat count delete delete_prefix delete_suffix downcase each_line gsub index insert length lines ljust match next partition prepend replace rindex rjust rpartition scan slice split squeeze sub swapcase tr tr_s upcase]

numerics = %w[abs abs2 ceil div divmod quo remainder round truncate]

ranges = %w[begin end size]
# rubocop:enable Layout/LineLength

def create_method(method_name, module_id, module_name)
  RubyMethod.create([
                      name: method_name,
                      ruby_module_id: module_id,
                      official_url: create_url(module_name, method_name)
                    ])
end

def create_url(module_name, method_name)
  if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html")).code == '200'
    "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html"
  else
    "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{method_name.upcase.slice(/[^?]+/)}--3F"
  end
end

[enumerables, arrays, hashs, strings, numerics, ranges].each_with_index do |methods, index|
  methods.each do |method_name|
    create_method(method_name, ruby_module_ids[index], module_names[index])
  end
end
