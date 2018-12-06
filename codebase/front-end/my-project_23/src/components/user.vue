<template>
  <div>
    <div class="post-head">
      <image class="head-icon" src="/static/images/girl.png" @click="$emit('custom-event-user')"></image>
      <div class="head-content">
        <span>{{posterUsername}}</span>
        <br>id: {{uid}}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['uid'],
  data () {
    return {
      posterUsername: ''
    }
  },
  methods: {
    getUser () {
      console.log('>>> getUser', this.uid)
      let that = this
      wx.request({
        method: 'GET',
        url: 'http://localhost:8080/demo/user/get?id=' + this.uid,
        header: { 'content-type': 'application/json' },
        success: async function (res) {
          if (res.statusCode === 200) {
            that.posterUsername = res.data.username
            console.log('>>> that.posterUsername', that.posterUsername)
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
    this.$forceUpdate()
  },
  onShow () {
    this.getUser()
    this.$forceUpdate()
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
