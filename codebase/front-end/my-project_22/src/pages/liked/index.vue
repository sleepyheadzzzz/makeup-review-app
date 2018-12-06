<template>
  <div>
    <div v-for="p in posts">
      <post v-bind:post="p"
            v-bind:currentUserId="
            user.id.toString()"
            @custom-event="userDetail(p.posterId)"
            @custom-event-postRefresh="postRefresh(p.id)"></post>
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
        console.log('>>> uer', this.user.id.toString())
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/post/liked?id=' + that.user.id.toString(),
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              that.posts = res.data.reverse()
              console.log(that.posts)
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
      postRefresh (id) {
        this.posts = this.posts.filter(p => p.id !== id)
        this.get()
      }
    },
    onShow () {
      this.posts = []
      this.user = wx.getStorageSync('user')
      if (this.user) {
        wx.showTabBar()
        this.get()
      }
    }
  }
</script>

<style scoped>
</style>
