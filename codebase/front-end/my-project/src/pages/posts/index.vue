<template>
  <div>
    <div v-for="p in posts">
      <post v-bind:post="p"></post>
    </div>
  </div>
</template>

<script>
  import post from '@/components/post'
  export default {
    components: {
      post: post
    },
    data () {
      return {
        posts: []
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
      }
    },
    onShow () {
      this.posts = []
      this.get()
      this.user = wx.getStorageSync('user')
      if (this.user) {
        wx.showTabBar()
      }
    }
  }
</script>

<style scoped>
</style>
