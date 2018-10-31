<template>
  <div class="post-container">
    <div class="post-head">
      <image class="head-icon" src="/static/images/girl.png"></image>
      <div class="head-content">
        <span>{{posterUsername}}</span>
        <span class="location-inactive">{{posterTime}}</span>
      </div>
    </div>
    <image class="post-image" :src="post.image"></image>
    <div class="post-title">
      <image src="/static/images/like-active.png" class="title-like"></image>
      <span> {{likes}} likes </span>
      <br>
      <span v-for="tag in tags" class="title-tag">#{{tag}} </span>
      <span>{{post.title}}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: ['post'],
  data () {
    return {
      likes: Math.ceil(Math.random() * 100),
      tags: ['life', 'weekend'],
      posterUsername: '',
      posterLocation: '',
      posterTime: ''
    }
  },
  methods: {
    getUser () {
      let that = this
      wx.request({
        method: 'GET',
        url: 'http://localhost:8080/demo/user/get?id=' + this.post.posterId,
        header: { 'content-type': 'application/json' },
        success: async function (res) {
          if (res.statusCode === 200) {
            that.posterUsername = res.data.username
            that.posterTime = new Date(that.post.timeStamp).toLocaleString()
          } else {
            // error
            console.log('>>> error getUser', res.data.error)
          }
        }
      })
    }
  },
  created () {
    this.getUser()
  },
  onShow () {
    this.getUser()
  }
}
</script>

<style>
  .location-inactive {
    color: gainsboro;
  }
  .post-container {
    border-bottom: 1px solid #a1a1a1;
    margin-top: 10px;
  }
  .post-image {
    object-fit: cover;
    width:100vw;
    height:100vw;
  }
  .post-head {
    display: flex;
    flex-direction: row;
  }
  .head-content {
    margin-left: 10px;
    display: flex;
    flex-direction: column;
  }
  .head-icon {
    width: 50px;
    height: 50px;
    border-radius: 25px;
  }
  .post-title {
    margin: 10px;
  }
  .title-tag {
    color: #ff777f
  }
  .title-like {
    width: 25px;
    height: 25px;
  }
</style>
