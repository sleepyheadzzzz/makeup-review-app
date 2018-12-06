<template xmlns="http://www.w3.org/1999/html">
  <div>
    <div class="post-container">
      <span>#</span><input v-model="searchInput" placeholder="search by tag name">
      <div class="post-action">
        <span v-on:click="updateSearch()">submit</span>
      </div>
    </div>

    <div v-for="p in posts">
      <post v-bind:post="p" v-bind:currentUserId="user.id.toString()" @custom-event="userDetail(p.posterId)"></post>
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
        posts: [],
        searchInput: ''
      }
    },
    methods: {
      updateSearch () {
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/post/search?key=' + this.searchInput.trim(),
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              that.posts = res.data.reverse()
            } else {
              // error
              console.log('>>> error updateSearch', res.data.error)
            }
          }
        })
      },
      userDetail (id) {
        if (id.toString() !== this.user.id.toString()) wx.navigateTo({ url: '/pages/otherProfile/main?id=' + id })
      },
      postRefresh () {
        this.posts = []
        this.updateSearch()
      }
    },
    onShow () {
      this.posts = []
      this.updateSearch()
      this.user = wx.getStorageSync('user')
      if (this.user) {
        wx.showTabBar()
      }
    }
  }
</script>

<style scoped>
  .post-container {
    display: flex;
    flex-direction: row;
  }
  .post-action {
    margin-left: auto;
  }
</style>
