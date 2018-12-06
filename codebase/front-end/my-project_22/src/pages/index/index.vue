<template>
  <div>
    <div class="header-block">
      <span class="title">Welcome, Hello World!</span>
    </div>
      <div class="body-block">
        <button class="button-facebook">
          Sign in with Facebook
        </button>

        <button class="button-google">
          Sign in with Google
        </button>

        <button class="button-email" v-on:click="navigageTo('/pages/signin/main')">
          Sign in with Email
        </button>
      </div>
  </div>
</template>

<script>

export default {
  data () {
    return {
      user: wx.getStorageSync('user')
    }
  },
  methods: {
    navigageTo (url) {
      wx.navigateTo({ url })
    }
  },
  created () {
    if (this.user) {
      wx.reLaunch({ url: '/pages/posts/main' })
    }
  },
  onShow () {
    if (wx.getStorageSync('user') || '') {
      wx.redirectTo({url: '/pages/posts/main'})
    }
  }
}
</script>

<style scoped>
  button {
    width: 80%;
  }
  .title {
    padding-left: 10%;
    color: white;
    top: 150px;
    position: absolute;
    font-size: 25px;
  }
  .header-block {
    background: #ff777f;
    display: inline-block;
    width: 100%;
    height: 200px;
  }
  .body-block {
    width: 100%;
    height: calc(100vh - 200px);
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
  }
  .button-facebook {
    background: #2584ff;
    color: white;
  }
  .button-google {
    background: #ff343f;
    color: white;
  }
  .button-email {
    background: #ff777f;
    color: white;
  }
</style>
