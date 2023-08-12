# frozen_string_literal: true

module MetaTagsHelper
  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 'Rubyの学習をサポートする Rubyフラッシュカード',
      reverse: true,
      charset: 'utf-8',
      description: 'RubyフラッシュカードはRuby学習者が効率良くRubyのメソッドを覚えることができるオンラインフラッシュカードサービスです。',
      keywords: 'Ruby, 学習, 効率の良い',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: :title,
        type: 'website',
        site_name: 'Rubyフラッシュカード',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://ruby-flash-card.fly.dev/',
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        url: request.original_url,
        description: :description,
        image: image_url('ogp.png')
      }
    }
  end
  # rubocop:enable Metrics/MethodLength

  def welcome_meta_tags
    default_meta_tags.deep_merge({
                                   title:,
                                   og: {
                                     title: title || 'Rubyフラッシュカード'
                                   },
                                   twitter: {
                                     title: title || 'Rubyフラッシュカード'
                                   }
                                 })
  end
end
