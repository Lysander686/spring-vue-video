<!-- Generated via vue.ftl by VueGenerator -->
<template>
  <div>
    <p>
      <button @click="add()" class="btn btn-white btn-sm btn-round">
        <i class="ace-icon fa fa-edit"></i>
        新增
      </button>&nbsp;
      <button @click="list(1)" class="btn btn-white btn-sm btn-round">
        <i class="ace-icon fa fa-refresh"></i>
        刷新
      </button>&nbsp;
    </p>
    <pagination ref="pagination" v-bind:list="list"></pagination>
    
    <!--  讲师列表  -->
    <div class="row">
      <div v-for="teacher in teachers" class="col-md-2">
        <div>
          <span class="profile-picture">
            <img v-show="!teacher.image" class="editable img-responsive editable-click editable-empty"
                 src="/static/image/讲师头像/头像1.jpg" v-bind:title="teacher.intro"/>
            <img v-show="teacher.image" class="editable img-responsive editable-click editable-empty"
                 v-bind:src="teacher.image" v-bind:title="teacher.intro"/>
          </span>
          
          <div class="space-4"></div>
          
          <div class="width-85 label label-info label-xlg arrowed-in arrowed-in-right">
            <div class="inline position-relative">
              <a href="javascript:;" class="user-title-label dropdown-toggle" data-toggle="dropdown">
                <i class="ace-icon fa fa-circle light-green"></i>
                &nbsp;
                <span class="white">{{teacher.position}}</span>
              </a>
            </div>
          </div>
        </div>
        
        <div class="space-4"></div>
        
        <div class="text-center">
          <a href="javascript:;" class="text-info bigger-110" v-bind:title="teacher.motto">
            <i class="ace-icon fa fa-user"></i>
            {{teacher.name}} [{{teacher.nickname}}]
          </a>
        </div>
        
        <div class="space-6"></div>
        
        <div class="profile-social-links align-center">
          <button v-on:click="edit(teacher)" class="btn btn-xs btn-info">
            <i class="ace-icon fa fa-pencil bigger-120"></i>
          </button>
          &nbsp;
          <button v-on:click="del(teacher.id)" class="btn btn-xs btn-danger">
            <i class="ace-icon fa fa-trash-o bigger-120"></i>
          </button>
        </div>
        
        <div class="hr hr16 dotted"></div>
      
      </div>
    </div>
    
    <!-- Modal -->
    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">表单: 添加讲师</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-2 control-label">id</label>
                <div class="col-sm-10">
                  <input v-model="teacher.id" class="form-control" placeholder="id">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                  <input v-model="teacher.name" class="form-control" placeholder="姓名">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">昵称</label>
                <div class="col-sm-10">
                  <input v-model="teacher.nickname" class="form-control" placeholder="昵称">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">头像</label>
                <div class="col-sm-10">
                  <input id="file-upload-input" type="file" class="form-control" placeholder="头像"
                         @change="uploadImage()">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">职位</label>
                <div class="col-sm-10">
                  <input v-model="teacher.position" class="form-control" placeholder="职位">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">座右铭</label>
                <div class="col-sm-10">
                  <input v-model="teacher.motto" class="form-control" placeholder="座右铭">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">简介</label>
                <div class="col-sm-10">
                  <textarea v-model="teacher.intro" class="form-control" rows="5"></textarea>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button v-on:click="save" type="button" class="btn btn-primary">保存</button>
          </div>
        </div>
      </div>
    </div><!-- Modal End -->
  
  </div>
</template>


<script>
  import Pagination from "@/components/pagination";

  export default {
    name: "business-teacher",
    data: function () {
      return {
        teacher: {},
        teachers: [],
      };
    },
    components: {
      Pagination
    },
    mounted() {
      let _this = this;
      _this.$refs.pagination.size = 5;
      _this.list(1);
    },
    methods: {
      add() {
        let _this = this;
        _this.teacher = {};
        $("#form-modal").modal("show");
      },

      edit(teacher) {
        let _this = this;
        _this.teacher = $.extend({}, teacher);
        $("#form-modal").modal("show");

      },

      save() {
        let _this = this;

        // 保存校验
        if (1 != 1
            || !Validator.require(_this.teacher.name, "姓名")
            || !Validator.length(_this.teacher.name, "姓名", 1, 50)
            || !Validator.length(_this.teacher.nickname, "昵称", 1, 50)
            || !Validator.length(_this.teacher.image, "头像", 1, 100)
            || !Validator.length(_this.teacher.position, "职位", 1, 50)
            || !Validator.length(_this.teacher.motto, "座右铭", 1, 50)
            || !Validator.length(_this.teacher.intro, "简介", 1, 500)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/teacher/save', _this.teacher)
            .then((response) => {
              Loading.hide();
              let resp = response.data;
              if (resp.success) {
                $("#form-modal").modal("hide");
                _this.list(1);
                Toast.success("保存成功");
              } else {
                Toast.warning(resp.message);
              }
            });
      },

      del(id) {
        let _this = this;
        Confirm.show("删除讲师后不可恢复", function () {
          Loading.show();
          _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/teacher/delete/' + id)
              .then((response) => {
                Loading.hide();
                let resp = response.data;
                if (resp.success) {
                  $('#form-modal').modal("hide");
                  _this.list(1);
                  Toast.success("删除成功");
                }
              });
        });
      },

      uploadImage() {
        let _this = this;
        let formData = new window.FormData();
        // key: "file"必须和后端controller参数名一致
        let file = document.querySelector('#file-upload-input').files[0];
        console.log(file);
        formData.append('file', file);
        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER + '/file/admin/upload', formData)
            .then((response) => {
              Loading.hide();
              let resp = response.data;
              if (resp.success) {
                Toast.success("图片上传成功");
              } else {
                Toast.error("图片上传失败");
                console.log(resp, response);
              }
            });
      },

      list(page) {
        let _this = this;
        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/teacher/list',
            {page: page, size: _this.$refs.pagination.size})
            .then((response) => {
              Loading.hide();
              let resp = response.data;
              _this.teachers = resp.content.list;
              _this.$refs.pagination.render(page, resp.content.total);
            });
      },
    }
  };
</script>

<style scoped>

</style>