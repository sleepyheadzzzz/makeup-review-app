<template>
  <div>
    <div class="header-block">
      <span class="title-message">{{message}}</span>
      <span class="title">Sign Up</span>
    </div>
    <div class="body-block">
        <input type="text" class="form-control" v-model="user.username" placeholder="username" />
        <input type="email" class="form-control" v-model="user.email" placeholder="email" />
        <input type="password" class="form-control" v-model="user.password" placeholder="password" />
      <div class="button-pair">
        <button class="button-clean" v-on:click="signup()">Confirm Sign Up</button>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        user: {
          username: '',
          email: '',
          password: '',
          id: ''
        },
        message: ''
      }
    },
    methods: {
      signup () {
        let that = this
        wx.request({
          method: 'POST',
          url: 'http://localhost:8080/demo/user/signup',
          data: this.user,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data.substring(0, 'success'.length) === 'success') {
                that.user.id = res.data.substring('success'.length)
                wx.setStorageSync('user', that.user)
                wx.switchTab({ url: '/pages/posts/main' })
                that.clear()
              } else {
                // invalid data
                that.message = res.data
              }
            } else {
              // error
              console.log('>>> error signup', res.data.error)
            }
          }
        })
      },
      clear () {
        this.user.username = ''
        this.user.password = ''
        this.user.email = ''
        this.user.id = ''
        this.message = ''
      }
    }
  }
</script>

<style scoped>
  .title-message {
    padding-left: 10%;
    color: white;
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
    width: 100%;
    height: 200px;
    display: flex;
    flex-direction: column;
  }
  .body-block {
    width: 100%;
    height: calc(100vh - 200px);
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
  }
  .form-control {
    display: block;
    border: 1px solid #ccc;
    margin-right: 15%;
    margin-left: 15%;
    padding-left: 10px;
    height: 50px;
    font-size: 25px;
  }
  .button-pair {
    margin-right: 10%;
    margin-left: 10%;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
  }
  .button-clean {
    display: block;
    background: white;
    color: #ff777f;
    border: 3px solid #ff777f;
    border-radius: 0;
  }
</style>
