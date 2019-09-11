jQuery ->
	if $('#infinite-scrolling').size() > 0
		$(window).on 'scroll', ->
			more_posts_url = $('.pagination .next_page').attr('href')
			if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
					$('.pagination').html('<img src="../../assets/ajax-loader.gif" alt="Loading..." title="Loading..." style="margin: 0 auto;display: block;" />')
					$.getScript more_posts_url
			return
		return