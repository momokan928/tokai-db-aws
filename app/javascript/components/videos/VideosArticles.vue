<template>
  <div id="app">
    <div class="video_articles">
      <div class="video_article" v-for="(video,$index) in videos" :key="$index">
        <router-link :to="{ name: 'VideosShow', params: { id: video.id } }">
          
          <div v-if="video.kind_of == 0" class="article-kind_of btn tetsuya">メイン</div>
          <div v-if="video.kind_of == 1" class="article-kind_of btn toshimitsu">控え室</div>
          <div v-if="video.kind_of == 2" class="article-kind_of btn ryo">個チャン</div>
          <div v-if="video.kind_of == 3" class="article-kind_of btn yumemaru">その他</div>

          <div class="article-image">
            <img :src="'https://img.youtube.com/vi/' + video.url + '/maxresdefault.jpg'">
          </div>

          <div class="article-column">
            <div class="article-title">
              <p class="article_title">{{video.title}}</p>
            </div>

            <div class="article_row">

              <div class="article-rate" v-if="video.rate == 1">
                <h3 class="S"> S </h3>
              </div>
              <div class="article-rate" v-else-if="video.rate == 2">
                <h3 class="A"> A </h3> 
              </div>
              <div class="article-rate" v-else-if="video.rate == 3">
                <h3 class="B"> B </h3> 
              </div>
              <div class="article-rate" v-else>
                <h3 class="C"> C </h3> 
              </div>

              <div class="article-mvp">
                <h3 v-if="video.mvp      == 1" class="tetsuya">てつや</h3>
                <h3 v-else-if="video.mvp == 2" class="shibayu">しばゆー</h3>
                <h3 v-else-if="video.mvp == 3" class="ryo">りょう</h3>
                <h3 v-else-if="video.mvp == 4" class="toshimitsu">としみつ</h3>
                <h3 v-else-if="video.mvp == 5" class="yumemaru">ゆめまる</h3>
                <h3 v-else-if="video.mvp == 6" class="mushimegane">虫眼鏡</h3>
                <h3 v-else class="tokai">該当無し</h3>
              </div>
              
              <div class="article-tags" >
                  <div class="article-tag btn" v-for="tag in video.random_tags" :key="tag.id">
                    <h3>{{ tag.name }}</h3>
                  </div>
              </div>

            </div>


          </div>
          <div class="article-date">
            {{ video.updated_on }}

            <div id="like-">
              <i v-if="users_id(video.users).includes(user)" class="fas fa-heart" style="color:red"> {{ video.users.length }} </i>
              <i v-else class="far fa-heart"> {{ video.users.length }} </i>
            </div>

          </div>

        </router-link>
      
      </div>

      <div class="google-adsense">  <!-- なぜか全動画一覧以外ではエラーが出る  -->
        <InFeedAdsense
          data-ad-layout-key="-6j+cr+4e+8-4s"
          data-ad-client="ca-pub-6030549237323507"
          data-ad-slot="8230351456">
        </InFeedAdsense>
      </div>

    </div>  <!-- video_articles -->
  </div>
</template>

<script>
import axios from 'axios';
import Ads from 'vue-google-adsense'

export default {
  components : {
  	Ads
  },
  data: function () {
    return {
      user: {},  //current_userのID
    }
  },
  
  props: [
    'videos',
  ],

  mounted () {
    axios  //currentuserのID
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data))
  },

  methods: {
    users_id(users) { //users_idにはvideoのusersのidがシンプルな配列で入る→ 連想配列では無くなったのでincludesメソッドが使える
      var user = this.user;
      var users_id = [];
      var hoge = [];

      for(hoge in users){
        users_id.push(users[hoge].id);  //例）users_id = [1,2]
      }
      return users_id 
    },
    
  },

}

</script>

<style lang="scss" scoped>



.article-kind_of {
  position: absolute;
  z-index: 10;
  margin: 9px 0 0 10px;
  border-radius: 20px;
}

@media screen and (min-width: 1000px){ //widthが900pxまでのCSS
  div[class*="video_articles"] {
    width: 100%;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    a{
      font-size: 30px;
    }
  }

  .video_article {
    margin-right: 0.5em;
    margin-bottom: 1em;
    width :24%;
    border: 2px solid rgb(238, 237, 237);
    box-shadow: 2px 2px 4px gray;
  }
  .video_article-show {
    width: 400px;
    border: 2px solid rgb(238, 237, 237)
  }
  .google-adsense {
    width: 24%;
  }

  // ↓記事が上にホバーするコード
  .video_article{
    -webkit-transform: translate(0);
    transform: translate(0) ;
    -webkit-transition: .3s ease-in-out;
    transition: .4s ease-in-out;
  }
  .video_article:hover {
    -webkit-transform: translateY(-10px) scale(1);
    transform: translateY(-10px) scale(1);
    opacity: 0.5;
  }
  // ↑記事が上にホバーするコード

  .article-image {// iframeのheightをレスポンシブにする　https://akros-ac.jp/8277/
    position: relative;
    width: 100%;
    height: 0;
    padding-top: 56%;

    iframe ,img{
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  }

  .article-column{
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    
  }

  .article-title {
    width : 100%;
    font-size :16px
  }

  .article_title{
    overflow: hidden;
    height: 3em;
    line-height: 1.7;
  }

  .article_row{
    height: 52px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .article-rate {
    width: 17%;
    display: flex;
    justify-content: center;
  }
  .S {
    color: gold;
  }
  .A {
    color: rgb(224, 12, 231);
  }
  .B {
    color: rgb(235, 29, 29);
  }
  .C {
    color: rgb(245, 158, 27);
  }

  .article-mvp {
    width: 25%;
    display: flex;
    justify-content: center;
    color:white;

    h3{
      white-space: nowrap;
      border-radius: 5px;
      padding: 1px 13px ;
      font-size: 16px;
    }
  }


  .article-tags{// ハッシュタグのデザイン
    width: 55%;
    height: 100%;
    display: flex;
    flex-wrap: wrap;

    .article-tag {
      width: 49%;
      height: 24px;
      margin: 0.5%;
      border-radius: 5px;
      background-color: rgb(0, 247, 255);
      display: flex;
      justify-content: center;
      align-items: center;

      h3 {
        font-size: 13px;
        color: white;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;

      }
    }
  }

  .article-date {
    display: inline;
    font-size :13px;
    a {
      font-size: 13px !important;
    }
  }
  div[id*="like-"]{ //inlineがないと横並びにならない
    display: inline;
    margin-left: 10px;
  }
}
//ここまでvideo記事のデザイン

@media screen and (max-width: 999px){ /*widthが999pxまでのCSS(スマホ用)*/
  .google-adsense {
    width: 100%;
  }
}

</style>