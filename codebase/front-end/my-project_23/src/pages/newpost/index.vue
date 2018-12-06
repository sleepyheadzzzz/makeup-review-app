<template>
  <div class="post-container">
    {{message}}
    <div class="post-head">
      <image class="head-icon" src="/static/images/girl.png"></image>
      <div class="head-content">
        <span>{{user.username}}</span>
        <span class="location-inactive">current location</span>
      </div>
      <div class="post-actions">
        <image class="head-icon-action" src="/static/images/post.png" v-on:click="add()"></image>
        <image class="head-icon-action" src="/static/images/random.png" v-on:click="newImage()"></image>
        <image class="head-icon-action" src="/static/images/clear.png" v-on:click="clear()"></image>
      </div>
    </div>
    <br>
    <image class="post-image" :src="post.image" v-on:click="addImage()"></image>
    <textarea class="post-title-input" placeholder="What's on you mind..." v-model="post.title"></textarea>

  </div>
</template>

<script>
  export default {
    data () {
      return {
        user: '',
        message: '',
        post: {
          posterId: '',
          title: '',
          image: ''
        }
      }
    },
    methods: {
      newImage () {
        this.post.image = 'https://picsum.photos/200/200/?image=' + Math.ceil(Math.random() * 100)
      },
      add () {
        if (this.post.image === '/static/images/plus.png') {
          console.log('>>> you arr adding default image')
          return
        }
        let that = this
        this.post.posterId = this.user.id
        wx.request({
          method: 'POST',
          url: 'http://localhost:8080/demo/post/add',
          data: this.post,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data === 'success') {
                that.clear()
              }
            } else {
              // error
              console.log('>>> error post', res.data.error)
            }
          }
        })
      },
      clear () {
        this.post.image = '/static/images/plus.png'
        this.post.title = ''
      },
      addImage () {
        this.post.posterId = this.user.id
        let that = this
        wx.chooseImage({
          count: 1,
          sizeType: ['original'],
          sourceType: ['album'],
          success: function (res) {
            var tempFilePaths = res.tempFilePaths
            that.post.image = tempFilePaths[0]
            wx.uploadFile({
              url: 'http://localhost:8080/',
              filePath: tempFilePaths[0],
              name: 'file',
              header: { 'Content-Type': 'multipart/form-data' },
              formData: {},
              success: function () {
                that.post.image = tempFilePaths[0]
              }
            })
          }
        })
      }
    },
    created () {
      this.user = wx.getStorageSync('user')
    },
    onShow () {
      this.user = wx.getStorageSync('user')
      this.message = ''
      this.clear()
    }
  }
</script>

<style scoped>
  .post-actions {
    margin-left: auto
  }
  .post-title-input {
    margin: 10px;
  }
  .location-inactive {
    color: gainsboro;
  }
  .post-container {
    margin-top: 10px;
  }
  .post-head {
    display: flex;
    flex-direction: row;
  }
  .post-image {
    object-fit: cover;
    width:100vw;
    height:100vw;
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
  .head-icon-action {
    width: 30px;
    height: 30px;
    margin: 10px;
  }


  /**index.wxss**/
  .container{
    width: 750rpx;
    height: 100%;
    position: relative;
  }
  .photo-wrap{
    width: 750rpx;
    height: 420rpx;
    text-align: center;
    position: fixed;
    bottom: 0rpx;
  }
  .photo-image-wrap{
    width: 196rpx;
    height: 260rpx;
  }
  .photo-image-wrap image{
    width: 190rpx;
    height: 190rpx;
  }
  .photo-image-wrap text{
    font-size: 17px;
    color: #000000;
    letter-spacing: -0.41px;
  }
  .photo-image-wrap1{
    position: absolute;
    left: 120rpx;
    bottom: 220rpx;
  }
  .photo-image-wrap2{
    position: absolute;
    right: 120rpx;
    bottom: 220rpx;
  }
  .close{
    width: 56rpx;
    height: 56rpx;
    position: absolute;
    left: 50%;
    margin-left: -28rpx;
    bottom: 20rpx;
  }
</style>
