# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: 'Ruby学習をサポートする Ruby Quiz',
      reverse: true,
      charset: 'utf-8',
      description: 'Ruby Quizはあなたのプログラミング学習を支えるパートナーです！',
      keywords: 'プログラミング, Ruby, フィヨルドブートキャンプ, FJORD BOOT CAMP',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: :title,
        type: 'website',
        site_name: 'Ruby Quiz',
        description: :description,
        image: image_url('ogp.png'),
        url: request.original_url,
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

  def welcome_meta_tags
    default_meta_tags.deep_merge({
                                   title:,
                                   og: {
                                     title: title || 'Ruby Quiz'
                                   },
                                   twitter: {
                                     title: title || 'Ruby Quiz'
                                   }
                                 })
  end
end
