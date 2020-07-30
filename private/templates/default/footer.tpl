<footer id="footer" class="midnight-blue">
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="text-center">
                    <a class="scrollup" href="#"><i class="fa fa-angle-up fa-3x"></i></a>
                </div>

                <div class="credits">
                    <h3>{str('page_title')}</h3>
                    <div>{get_text('address')}</div>
                </div>

                <hr>

                <div class="credits">OnePage Theme. All Rights Reserved.<a href="https://bootstrapmade.com/">Bootstrap Templates</a> by <a href="https://bootstrapmade.com/">BootstrapMade</a><!--All the links in the footer should remain intact. You can delete the links only if you purchased the pro version. Licensing information: https://bootstrapmade.com/license/ Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=OnePage --></div>

                <div class="credits">{str('footer_credits')}</div>

                {*<small>*}
                    {*<a href="{url('/editor.php')}">ผู้ดูแลเข้าสู่ระบบ</a>*}
                {*</small>*}
            </div>
        </div>
    </div>
</footer>

<script src="{url('/js/jquery.js')}"></script>
<script src="{url('/js/bootstrap.min.js')}"></script>
<script src="{url('/js/jquery.prettyPhoto.js')}"></script>
<script src="{url('/js/jquery.isotope.min.js')}"></script>
<script src="{url('/js/wow.min.js')}"></script>
<script src="{url('/js/jquery.easing.min.js')}"></script>
{if isset($jsFiles)}
    {foreach $jsFiles as $jsFile}
        <script src="{$jsFile}"></script>
    {/foreach}
{/if}

</body>
</html>