<template>
  <div class="post-container">
    <div class="post-head">
      <image class="head-icon" src="/static/images/girl.png" @click="$emit('custom-event')"></image>
      <div class="head-content">
        <span>{{posterUsername}}</span>
        <span class="location-inactive">{{posterTime}}</span>
      </div>
    </div>
    <image class="post-image" :src="post.image"></image>
    <div class="post-title">
      <image :src="liked ? '/static/images/like-active.png' : '/static/images/like-inactive.png'" class="title-like"
             @click="like()"></image>
      <image src="/static/images/comment.png" class="title-like" @click="comment(post.id)"></image>
      <br>
      <span> {{likes.length}} likes </span>
      <span> {{commentsCount}} comments </span>
      <br>
      <span v-html="titleWithTags"></span>
    </div>
  </div>
</template>

<script>
export default {
  props: ['post', 'currentUserId'],
  data () {
    return {
      likes: new Set(this.post.likes.split(',').filter(n => n !== '')),
      liked: this.post.likes.split(',').filter(n => n !== '').filter(n => n === this.currentUserId).length > 0,
      posterUsername: '',
      posterLocation: '',
      posterTime: '',
      commentsCount: 0,
      titleWithTags: this.parseTags(this.post.title)
    }
  },
  methods: {
    comment (id) {
      wx.navigateTo({url: '/pages/comments/main?id=' + id})
    },
    parseTags (s) {
      let ret = ''
      for (let i = 0; i < s.length; i++) {
        let tagText = ''
        if (s[i] === '#') {
          while (s[i] !== ' ' && i !== s.length) {
            tagText += s[i]
            i++
          }
        }
        if (tagText !== '') {
          ret += '<span class="title-tag">' + tagText + '</span>'
        }
        if (s[i] !== undefined) ret += s[i]
      }
      return ret
    },
    getUser () {
      this.getComments()
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
    },
    like () {
      let that = this
      wx.request({
        method: 'Post',
        url: 'http://localhost:8080/demo/post/like?id=' + this.post.id,
        data: wx.getStorageSync('user'),
        header: { 'content-type': 'application/json' },
        success: async function (res) {
          if (res.statusCode === 200) {
            if (that.liked) {
              that.likes.delete(that.currentUserId)
              that.liked = false
              that.$emit('custom-event-postRefresh')
            } else {
              that.likes.add(that.currentUserId)
              that.liked = true
            }
          } else {
            // error
            console.log('>>> error like', res.data.error)
          }
        }
      })
    },
    getComments () {
      let that = this
      wx.request({
        method: 'GET',
        url: 'http://localhost:8080/demo/comment/postcomments?id=' + this.post.id,
        header: { 'content-type': 'application/json' },
        success: async function (res) {
          if (res.statusCode === 200) {
            that.commentsCount = res.data.length
          } else {
            // error
            console.log('>>> error getComments', res.data.error)
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
    margin: 5px;
    width: 25px;
    height: 25px;
  }
</style>
