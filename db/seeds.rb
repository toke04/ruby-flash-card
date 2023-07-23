# frozen_string_literal: true

User.create([
              id: User.last.id + 1,
              name: 'toke',
              provider: 'github',
              uid: ENV['ADMIN_USER_UID'],
              image: 'https://avatars.githubusercontent.com/u/54713809?v=4',
              admin: true
            ])

module_names = %w[Enumerable Array Hash String Numeric Range Date]

module_names.each do |module_name|
  RubyModule.create([
                      name: module_name
                    ])
end

ruby_module_ids = RubyModule.all.order(id: 'ASC').pluck(:id)

# rubocop:disable Layout/LineLength
enumerable_methods = %w[all? any? chain chunk chunk_while collect collect_concat compact count cycle detect drop drop_while each_cons each_entry each_slice
                        each_with_index each_with_object entries filter filter_map find find_all find_index first flat_map grep grep_v group_by include? inject lazy map max max_by member? min min_by minmax minmax_by none? one? partition reduce reject reverse_each select slice_after slice_before slice_when sort sort_by sum take take_while uniq zip]
array_methods = %w[append assoc at bsearch bsearch_index clear clone combination concat delete delete_at delete_if
                   difference dig drop drop_while dup each each_index empty? eql? fetch fill filter find_index first flatten hash include? index insert inspect intersect? intersection join keep_if last length map max min minmax none? one? pack permutation pop prepend product push rassoc reject repeated_combination repeated_permutation replace reverse reverse_each rindex rotate sample select shift shuffle size slice sort  take_while transpose union unshift values_at]
hash_methods = %w[assoc clear clone compact default default_proc delete delete_if dig dup each each_key each_pair
                  each_value empty? eql? equal? except fetch fetch_values filter flatten has_key? has_value? hash include? inspect invert keep_if key key? keys length member? merge rassoc rehash reject replace select shift size slice transform_keys transform_values]
string_methods = %w[byteindex byteslice capitalize casecmp casecmp? center chars chomp chop chr clear codepoints concat
                    count dedup delete delete_prefix delete_suffix downcase dump each_char each_codepoint each_grapheme_cluster each_line empty? end_with? eql? gsub hash hex include? index insert inspect length lines ljust lstrip match match? next oct ord partition prepend replace reverse rindex rjust rpartition rstrip scan scrub size slice split squeeze start_with? strip sub succ sum swapcase tr tr_s undump upcase upto]
numeric_methods = %w[abs abs2 ceil div divmod eql? fdiv infinite? integer? negative? nonzero? positive? quo
                     remainder round step truncate zero?]
range_methods = %w[begin bsearch cover? each end entries eql? exclude_end? first include? inspect last max member? min minmax size step]
date_methods = %w[day downto friday? mday mon monday? month new_start next next_day next_month next_year prev_day prev_month prev_year saturday? start step
                  strftime sunday? thursday? to_date to_datetime to_time tuesday? upto wday wednesday? yday year]
# rubocop:enable Layout/LineLength

def create_url(module_name, method_name)
  if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html")).code == '200'
    "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html"
  else
    "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{method_name.upcase.slice(/[^?]+/)}--3F"
  end
end

def create_method(method_name, module_id, module_name)
  RubyMethod.create([
                      name: method_name,
                      ruby_module_id: module_id,
                      official_url: create_url(module_name, method_name)
                    ])
end

enumerable_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[0], module_names[0])
end

array_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[1], module_names[1])
end

hash_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[2], module_names[2])
end

string_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[3], module_names[3])
end

numeric_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[4], module_names[4])
end

range_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[5], module_names[5])
end

date_methods.each do |date_method|
  create_method(date_method, ruby_module_ids[6], module_names[6])
end
