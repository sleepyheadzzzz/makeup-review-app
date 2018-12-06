<template>
  <div>
    <div class="post-container">
      <input class="post-input" v-model="commentInput" placeholder="make a comment">
      <div class="post-action">
        <span v-on:click="addComment()">submit</span>
      </div>
    </div>
    <div v-for="c in comments" class="comments-container">
      <comment v-bind:comment="c" @custom-event="userDetail(c.posterId)"></comment>
    </div>
  </div>
</template>

<script>
  import comment from '@/components/comment'
  export default {
    components: {
      comment: comment
    },
    data () {
      return {
        user: '',
        comments: [],
        postId: '',
        commentInput: '',
        comment: {
          posterId: '',
          postId: '',
          comment: ''
        }
      }
    },
    methods: {
      getComments () {
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/comment/postcomments?id=' + that.postId,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              that.comments = []
              that.comments = res.data.reverse()
            } else {
              // error
              console.log('>>> error getComments', res.data.error)
            }
          }
        })
      },
      addComment () {
        if (this.commentInput.trim().length === 0) return
        let that = this
        this.comment.posterId = this.user.id
        this.comment.postId = this.postId
        this.comment.comment = this.commentInput
        wx.request({
          method: 'POST',
          url: 'http://localhost:8080/demo/comment/add',
          data: that.comment,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data === 'success') {
                that.clear()
                that.comments = []
                that.getComments()
              }
            } else {
              // error
              console.log('>>> error addComment', res.data.error)
            }
          }
        })
      },
      clear () {
        this.commentInput = ''
      },
      userDetail (id) {
        if (id.toString() !== this.user.id.toString()) wx.navigateTo({ url: '/pages/otherProfile/main?id=' + id })
      }
    },
    onLoad: function (options) {
      this.user = wx.getStorageSync('user')
      this.postId = decodeURIComponent(options.id)
      this.getComments()
    },
    onShow: function (options) {
      this.user = wx.getStorageSync('user')
      this.postId = decodeURIComponent(options.id)
      this.getComments()
    }
  }
</script>

<style scoped>
  .post-container {
    position: sticky;
    top: 0;
    background-color: white;
    display: flex;
    flex-direction: row;
  }
  .post-action {
    margin-left: auto;
  }
</style>
