<template>
  <div>
    <div v-for="id in userIds">
      <user v-bind:uid="id" @custom-event-user="userDetail(id)"></user>
    </div>
  </div>
</template>

<script>
  import user from '@/components/user'
  export default {
    components: {
      user: user
    },
    data () {
      return {
        posts: [],
        userIds: []
      }
    },
    methods: {
      get () {
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/post/all',
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              that.posts = res.data.reverse()
            } else {
              // error
              console.log('>>> error getPosts', res.data.error)
            }
          }
        })
      },
      userDetail (id) {
        if (id.toString() !== this.user.id.toString()) wx.navigateTo({ url: '/pages/otherProfile/main?id=' + id })
      },
      postRefresh () {
        this.posts = []
        this.get()
      }
    },
    onShow () {
      this.posts = []
      this.get()
      this.user = wx.getStorageSync('user')
      if (this.user) {
        wx.showTabBar()
      }
    },
    onLoad: function (options) {
      this.userIds = decodeURIComponent(options.userIds).split(',').filter(n => n !== '')
    }
  }
</script>

<style scoped>
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
</style>
