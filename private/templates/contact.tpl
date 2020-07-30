<div class="container-fluid" style="margin-top: 100px;">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <h2>{str('page_title')}</h2>
            <div style="margin-top: 20px;">
                <h4>{str('contact')}</h4>

                {if trim($contact['address']) != ''}
                    <p>
                        <i class="fa fa-map-marker"></i>
                        <strong>{str('contact_address')}</strong><br>
                        　{$contact['address']}
                    </p>
                {/if}

                {if trim($contact['email']) != ''}
                    <p>
                        <i class="fa fa-envelope"></i>
                        <strong>{str('contact_email')}</strong><br>
                        　<a href="mailto:{$contact['email']}">{$contact['email']}</a>
                    </p>
                {/if}

                {if trim($contact['tel']) != ''}
                    <p>
                        <i class="fa fa-phone"></i>
                        <strong>{str('contact_tel')}</strong><br>
                        　{$contact['tel']}
                    </p>
                {/if}

                {if trim($contact['fax']) != ''}
                    <p>
                        <i class="fa fa-print"></i>
                        <strong>{str('contact_fax')}</strong><br>
                        　{$contact['fax']}
                    </p>
                {/if}

                {if trim($contact['facebook_url']) != ''}
                    <p>
                        <i class="fa fa-facebook-square"></i>
                        <strong>{str('contact_facebook')}</strong><br>
                        　<a href="https://facebook.com/{$contact['facebook_url']}">{$contact['facebook_name']}</a>
                    </p>
                {/if}

                {if trim($contact['twitter']) != ''}
                    <p>
                        <i class="fa fa-twitter"></i>
                        <strong>{str('contact_twitter')}</strong><br>
                        　<a href="https://twitter.com/{$contact['twitter']}">@{$contact['twitter']}</a>
                    </p>
                {/if}

                {if trim($contact['instagram']) != ''}
                    <p>
                        <i class="fa fa-instagram"></i>
                        <strong>{str('contact_instagram')}</strong><br>
                        　<a href="https://instagram.com/{$contact['instagram']}">@{$contact['instagram']}</a>
                    </p>
                {/if}

                {if trim($contact['youtube_url'] != '')}
                    <p>
                        <i class="fa fa-youtube-play"></i>
                        <strong>{str('contact_youtube')}</strong><br>
                        　<a href="https://youtube.com/channel/{$contact['youtube_url']}">{$contact['youtube_name']}</a>
                    </p>
                {/if}

                {if trim($contact['line_ad']) != ''}
                    <p>
                        @
                        <strong>{str('contact_line')}</strong><br>
                        　{$contact['line_ad']}
                    </p>
                {/if}

            </div>
        </div>
    </div>
</div>