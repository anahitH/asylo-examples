; ModuleID = 'snake_server.bc'
source_filename = "snake_server.cc"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.grpc::Status" = type { i32, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string" }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%"class.examples::grpc_server::SnakeDefaultTypeInternal" = type opaque
%"class.examples::grpc_server::ScreenDefaultTypeInternal" = type opaque
%"class.examples::grpc_server::SnakeServer" = type <{ %"class.examples::grpc_server::SnakeService::Service", %struct.snake_t, %struct.screen_t, [4 x i8] }>
%"class.examples::grpc_server::SnakeService::Service" = type { %"class.grpc::Service" }
%"class.grpc::Service" = type { i32 (...)**, %"class.grpc::ServerInterface"*, %"class.std::vector" }
%"class.grpc::ServerInterface" = type { %"class.grpc::internal::CallHook" }
%"class.grpc::internal::CallHook" = type { i32 (...)** }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<std::unique_ptr<grpc::internal::RpcServiceMethod, std::default_delete<grpc::internal::RpcServiceMethod> >, std::allocator<std::unique_ptr<grpc::internal::RpcServiceMethod, std::default_delete<grpc::internal::RpcServiceMethod> > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::unique_ptr<grpc::internal::RpcServiceMethod, std::default_delete<grpc::internal::RpcServiceMethod> >, std::allocator<std::unique_ptr<grpc::internal::RpcServiceMethod, std::default_delete<grpc::internal::RpcServiceMethod> > > >::_Vector_impl" = type { %"class.std::unique_ptr"*, %"class.std::unique_ptr"*, %"class.std::unique_ptr"* }
%"class.std::unique_ptr" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Head_base.1" }
%"struct.std::_Head_base.1" = type { %"class.grpc::internal::RpcServiceMethod"* }
%"class.grpc::internal::RpcServiceMethod" = type { %"class.grpc::internal::RpcMethod", i8*, i32, %"class.std::unique_ptr.2" }
%"class.grpc::internal::RpcMethod" = type { i8*, i32, i8* }
%"class.std::unique_ptr.2" = type { %"class.std::__uniq_ptr_impl.3" }
%"class.std::__uniq_ptr_impl.3" = type { %"class.std::tuple.4" }
%"class.std::tuple.4" = type { %"struct.std::_Tuple_impl.5" }
%"struct.std::_Tuple_impl.5" = type { %"struct.std::_Head_base.10" }
%"struct.std::_Head_base.10" = type { %"class.grpc::internal::MethodHandler"* }
%"class.grpc::internal::MethodHandler" = type { i32 (...)** }
%struct.snake_t = type { i32, i32, i32, [100 x %struct.snake_segment_t] }
%struct.snake_segment_t = type { i32, i32 }
%struct.screen_t = type { i32, i32, i32, i32, i32, [22 x [78 x i8]] }
%"class.grpc::ServerContext" = type { %"class.grpc::ServerContext::CompletionOp"*, i8, i8*, %"class.grpc::internal::CallbackWithSuccessTag", %struct.gpr_timespec, %struct.grpc_call*, %"class.grpc::CompletionQueue"*, i8, %"class.std::shared_ptr", %"class.grpc::internal::MetadataMap", %"class.std::multimap.14", %"class.std::multimap.14", i8, i32, i32, [4 x i8], %"class.grpc::internal::CallOpSet", i8, %"class.grpc::experimental::ServerRpcInfo"* }
%"class.grpc::ServerContext::CompletionOp" = type opaque
%"class.grpc::internal::CallbackWithSuccessTag" = type { %struct.grpc_experimental_completion_queue_functor, %struct.grpc_call*, %"class.std::function", %"class.grpc::internal::CompletionQueueTag"* }
%struct.grpc_experimental_completion_queue_functor = type { void (%struct.grpc_experimental_completion_queue_functor*, i32)* }
%"class.std::function" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, i8*)* }
%"class.std::_Function_base" = type { %"union.std::_Any_data", i1 (%"union.std::_Any_data"*, %"union.std::_Any_data"*, i32)* }
%"union.std::_Any_data" = type { %"union.std::_Nocopy_types" }
%"union.std::_Nocopy_types" = type { { i64, i64 } }
%"class.grpc::internal::CompletionQueueTag" = type { i32 (...)** }
%struct.gpr_timespec = type { i64, i32, i32 }
%struct.grpc_call = type opaque
%"class.grpc::CompletionQueue" = type { %"class.grpc::GrpcLibraryCodegen.base", %struct.grpc_completion_queue*, i64 }
%"class.grpc::GrpcLibraryCodegen.base" = type <{ i32 (...)**, i8 }>
%struct.grpc_completion_queue = type opaque
%"class.std::shared_ptr" = type { %"class.std::__shared_ptr" }
%"class.std::__shared_ptr" = type { %"class.grpc::AuthContext"*, %"class.std::__shared_count" }
%"class.grpc::AuthContext" = type { i32 (...)** }
%"class.std::__shared_count" = type { %"class.std::_Sp_counted_base"* }
%"class.std::_Sp_counted_base" = type { i32 (...)**, i32, i32 }
%"class.grpc::internal::MetadataMap" = type { i8, %struct.grpc_metadata_array, %"class.std::multimap" }
%struct.grpc_metadata_array = type { i64, i64, %struct.grpc_metadata* }
%struct.grpc_metadata = type { %struct.grpc_slice, %struct.grpc_slice, i32, %struct.anon }
%struct.grpc_slice = type { %struct.grpc_slice_refcount*, %"union.grpc_slice::grpc_slice_data" }
%struct.grpc_slice_refcount = type { %struct.grpc_slice_refcount_vtable*, %struct.grpc_slice_refcount* }
%struct.grpc_slice_refcount_vtable = type { void (i8*)*, void (i8*)*, {}*, {}* }
%"union.grpc_slice::grpc_slice_data" = type { %"struct.grpc_slice::grpc_slice_data::grpc_slice_refcounted", [8 x i8] }
%"struct.grpc_slice::grpc_slice_data::grpc_slice_refcounted" = type { i8*, i64 }
%struct.anon = type { [4 x i8*] }
%"class.std::multimap" = type { %"class.std::_Rb_tree" }
%"class.std::_Rb_tree" = type { %"struct.std::_Rb_tree<grpc::string_ref, std::pair<const grpc::string_ref, grpc::string_ref>, std::_Select1st<std::pair<const grpc::string_ref, grpc::string_ref> >, std::less<grpc::string_ref>, std::allocator<std::pair<const grpc::string_ref, grpc::string_ref> > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<grpc::string_ref, std::pair<const grpc::string_ref, grpc::string_ref>, std::_Select1st<std::pair<const grpc::string_ref, grpc::string_ref> >, std::less<grpc::string_ref>, std::allocator<std::pair<const grpc::string_ref, grpc::string_ref> > >::_Rb_tree_impl" = type { %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_key_compare" = type { %"struct.std::less" }
%"struct.std::less" = type { i8 }
%"struct.std::_Rb_tree_header" = type { %"struct.std::_Rb_tree_node_base", i64 }
%"struct.std::_Rb_tree_node_base" = type { i32, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }
%"class.std::multimap.14" = type { %"class.std::_Rb_tree.15" }
%"class.std::_Rb_tree.15" = type { %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl" = type { %"struct.std::_Rb_tree_key_compare.19", %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_key_compare.19" = type { %"struct.std::less.20" }
%"struct.std::less.20" = type { i8 }
%"class.grpc::internal::CallOpSet" = type <{ %"class.grpc::internal::CallOpSetInterface", %"class.grpc::internal::CallOpSendInitialMetadata", %"class.grpc::internal::CallOpSendMessage", i8*, i8*, %"class.grpc::internal::Call", i8, [7 x i8], %"class.grpc::internal::InterceptorBatchMethodsImpl", i8, [7 x i8] }>
%"class.grpc::internal::CallOpSetInterface" = type { %"class.grpc::internal::CompletionQueueTag" }
%"class.grpc::internal::CallOpSendInitialMetadata" = type { i8, i8, i32, i64, %"class.std::multimap.14"*, %struct.grpc_metadata*, %struct.anon.22 }
%struct.anon.22 = type { i8, i32 }
%"class.grpc::internal::CallOpSendMessage" = type { i8, %"class.grpc::ByteBuffer", %"class.grpc::WriteOptions" }
%"class.grpc::ByteBuffer" = type { %struct.grpc_byte_buffer* }
%struct.grpc_byte_buffer = type { i8*, i32, %"union.grpc_byte_buffer::grpc_byte_buffer_data" }
%"union.grpc_byte_buffer::grpc_byte_buffer_data" = type { %"struct.grpc_byte_buffer::grpc_byte_buffer_data::grpc_compressed_buffer" }
%"struct.grpc_byte_buffer::grpc_byte_buffer_data::grpc_compressed_buffer" = type { i32, %struct.grpc_slice_buffer }
%struct.grpc_slice_buffer = type { %struct.grpc_slice*, %struct.grpc_slice*, i64, i64, i64, [8 x %struct.grpc_slice] }
%"class.grpc::WriteOptions" = type <{ i32, i8, [3 x i8] }>
%"class.grpc::internal::Call" = type { %"class.grpc::internal::CallHook"*, %"class.grpc::CompletionQueue"*, %struct.grpc_call*, i32, %"class.grpc::experimental::ClientRpcInfo"*, %"class.grpc::experimental::ServerRpcInfo"* }
%"class.grpc::experimental::ClientRpcInfo" = type { %"class.grpc::ClientContext"*, i8*, %"class.grpc::ChannelInterface"*, %"class.std::vector.27", i8, i64 }
%"class.grpc::ClientContext" = type { i8, i8, i8, i8, i8, %"class.std::shared_ptr.46", %"class.std::mutex", %struct.grpc_call*, i8, %struct.gpr_timespec, %"class.std::__cxx11::basic_string", %"class.std::shared_ptr.63", %"class.std::shared_ptr", %struct.census_context*, %"class.std::multimap.14", %"class.grpc::internal::MetadataMap", %"class.grpc::internal::MetadataMap", %struct.grpc_call*, %"class.grpc::PropagationOptions", i32, i8, %"class.std::__cxx11::basic_string", %"class.grpc::experimental::ClientRpcInfo" }
%"class.std::shared_ptr.46" = type { %"class.std::__shared_ptr.47" }
%"class.std::__shared_ptr.47" = type { %"class.grpc::Channel"*, %"class.std::__shared_count" }
%"class.grpc::Channel" = type { %"class.grpc::ChannelInterface", %"class.grpc::internal::CallHook", %"class.std::enable_shared_from_this", %"class.grpc::GrpcLibraryCodegen.base", %"class.std::__cxx11::basic_string", %struct.grpc_channel*, %"class.std::mutex", %"class.grpc::CompletionQueue"*, %"class.std::vector.49" }
%"class.grpc::ChannelInterface" = type { i32 (...)** }
%"class.std::enable_shared_from_this" = type { %"class.std::weak_ptr" }
%"class.std::weak_ptr" = type { %"class.std::__weak_ptr" }
%"class.std::__weak_ptr" = type { %"class.grpc::Channel"*, %"class.std::__weak_count" }
%"class.std::__weak_count" = type { %"class.std::_Sp_counted_base"* }
%struct.grpc_channel = type opaque
%"class.std::vector.49" = type { %"struct.std::_Vector_base.50" }
%"struct.std::_Vector_base.50" = type { %"struct.std::_Vector_base<std::unique_ptr<grpc::experimental::ClientInterceptorFactoryInterface, std::default_delete<grpc::experimental::ClientInterceptorFactoryInterface> >, std::allocator<std::unique_ptr<grpc::experimental::ClientInterceptorFactoryInterface, std::default_delete<grpc::experimental::ClientInterceptorFactoryInterface> > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::unique_ptr<grpc::experimental::ClientInterceptorFactoryInterface, std::default_delete<grpc::experimental::ClientInterceptorFactoryInterface> >, std::allocator<std::unique_ptr<grpc::experimental::ClientInterceptorFactoryInterface, std::default_delete<grpc::experimental::ClientInterceptorFactoryInterface> > > >::_Vector_impl" = type { %"class.std::unique_ptr.54"*, %"class.std::unique_ptr.54"*, %"class.std::unique_ptr.54"* }
%"class.std::unique_ptr.54" = type { %"class.std::__uniq_ptr_impl.55" }
%"class.std::__uniq_ptr_impl.55" = type { %"class.std::tuple.56" }
%"class.std::tuple.56" = type { %"struct.std::_Tuple_impl.57" }
%"struct.std::_Tuple_impl.57" = type { %"struct.std::_Head_base.62" }
%"struct.std::_Head_base.62" = type { %"class.grpc::experimental::ClientInterceptorFactoryInterface"* }
%"class.grpc::experimental::ClientInterceptorFactoryInterface" = type { i32 (...)** }
%"class.std::mutex" = type { %"class.std::__mutex_base" }
%"class.std::__mutex_base" = type { %union.pthread_mutex_t }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::shared_ptr.63" = type { %"class.std::__shared_ptr.64" }
%"class.std::__shared_ptr.64" = type { %"class.grpc::CallCredentials"*, %"class.std::__shared_count" }
%"class.grpc::CallCredentials" = type { %"class.grpc::GrpcLibraryCodegen.base", [7 x i8] }
%struct.census_context = type opaque
%"class.grpc::PropagationOptions" = type { i32 }
%"class.std::vector.27" = type { %"struct.std::_Vector_base.28" }
%"struct.std::_Vector_base.28" = type { %"struct.std::_Vector_base<std::unique_ptr<grpc::experimental::Interceptor, std::default_delete<grpc::experimental::Interceptor> >, std::allocator<std::unique_ptr<grpc::experimental::Interceptor, std::default_delete<grpc::experimental::Interceptor> > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::unique_ptr<grpc::experimental::Interceptor, std::default_delete<grpc::experimental::Interceptor> >, std::allocator<std::unique_ptr<grpc::experimental::Interceptor, std::default_delete<grpc::experimental::Interceptor> > > >::_Vector_impl" = type { %"class.std::unique_ptr.32"*, %"class.std::unique_ptr.32"*, %"class.std::unique_ptr.32"* }
%"class.std::unique_ptr.32" = type { %"class.std::__uniq_ptr_impl.33" }
%"class.std::__uniq_ptr_impl.33" = type { %"class.std::tuple.34" }
%"class.std::tuple.34" = type { %"struct.std::_Tuple_impl.35" }
%"struct.std::_Tuple_impl.35" = type { %"struct.std::_Head_base.40" }
%"struct.std::_Head_base.40" = type { %"class.grpc::experimental::Interceptor"* }
%"class.grpc::experimental::Interceptor" = type { i32 (...)** }
%"class.grpc::internal::InterceptorBatchMethodsImpl" = type { %"class.grpc::experimental::InterceptorBatchMethods", %"struct.std::array", i64, i8, i8, %"class.grpc::internal::Call"*, %"class.grpc::internal::CallOpSetInterface"*, %"class.std::function.41", %"class.grpc::ByteBuffer"*, %"class.std::multimap.14"*, i32*, %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"*, %"class.grpc::Status", %"class.std::multimap.14"*, i8*, %"class.grpc::internal::MetadataMap"*, %"class.grpc::Status"*, %"class.grpc::internal::MetadataMap"* }
%"class.grpc::experimental::InterceptorBatchMethods" = type { i32 (...)** }
%"struct.std::array" = type { [12 x i8] }
%"class.std::function.41" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*)* }
%"class.grpc::experimental::ServerRpcInfo" = type { %"class.grpc::ServerContext"*, i8*, %"struct.std::atomic", %"class.std::vector.27" }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i32 }
%"class.examples::grpc_server::EnclaveInput" = type { %"class.google::protobuf::Message", %"class.google::protobuf::internal::InternalMetadataWithArena", %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::CachedSize", %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Screen"* }
%"class.google::protobuf::Message" = type { %"class.google::protobuf::MessageLite" }
%"class.google::protobuf::MessageLite" = type { i32 (...)** }
%"class.google::protobuf::internal::InternalMetadataWithArena" = type { %"class.google::protobuf::internal::InternalMetadataWithArenaBase" }
%"class.google::protobuf::internal::InternalMetadataWithArenaBase" = type { i8* }
%"class.google::protobuf::internal::HasBits" = type { [1 x i32] }
%"class.google::protobuf::internal::CachedSize" = type { %"struct.std::atomic" }
%"class.examples::grpc_server::Snake" = type <{ %"class.google::protobuf::Message", %"class.google::protobuf::internal::InternalMetadataWithArena", %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::CachedSize", %"class.google::protobuf::RepeatedPtrField", i32, i32, i32, [4 x i8] }>
%"class.google::protobuf::RepeatedPtrField" = type { %"class.google::protobuf::internal::RepeatedPtrFieldBase" }
%"class.google::protobuf::internal::RepeatedPtrFieldBase" = type { %"class.google::protobuf::Arena"*, i32, i32, %"struct.google::protobuf::internal::RepeatedPtrFieldBase::Rep"* }
%"class.google::protobuf::Arena" = type { %"class.google::protobuf::internal::ArenaImpl", void (%"class.std::type_info"*, i64, i8*)*, void (%"class.google::protobuf::Arena"*, i8*, i64)*, void (%"class.google::protobuf::Arena"*, i8*, i64)*, i8* }
%"class.google::protobuf::internal::ArenaImpl" = type { %"struct.std::atomic.66", %"struct.std::atomic.66", %"struct.std::atomic.68", %"class.google::protobuf::internal::ArenaImpl::Block"*, i64, %"struct.google::protobuf::internal::ArenaImpl::Options" }
%"struct.std::atomic.66" = type { %"struct.std::__atomic_base.67" }
%"struct.std::__atomic_base.67" = type { %"class.google::protobuf::internal::ArenaImpl::SerialArena"* }
%"class.google::protobuf::internal::ArenaImpl::SerialArena" = type { %"class.google::protobuf::internal::ArenaImpl"*, i8*, %"class.google::protobuf::internal::ArenaImpl::Block"*, %"struct.google::protobuf::internal::ArenaImpl::CleanupChunk"*, %"class.google::protobuf::internal::ArenaImpl::SerialArena"*, i8*, i8*, %"struct.google::protobuf::internal::ArenaImpl::CleanupNode"*, %"struct.google::protobuf::internal::ArenaImpl::CleanupNode"* }
%"struct.google::protobuf::internal::ArenaImpl::CleanupChunk" = type { i64, %"struct.google::protobuf::internal::ArenaImpl::CleanupChunk"*, [1 x %"struct.google::protobuf::internal::ArenaImpl::CleanupNode"] }
%"struct.google::protobuf::internal::ArenaImpl::CleanupNode" = type { i8*, void (i8*)* }
%"struct.std::atomic.68" = type { %"struct.std::__atomic_base.69" }
%"struct.std::__atomic_base.69" = type { i64 }
%"class.google::protobuf::internal::ArenaImpl::Block" = type { %"class.google::protobuf::internal::ArenaImpl::Block"*, i64, i64 }
%"struct.google::protobuf::internal::ArenaImpl::Options" = type { i64, i64, i8*, i64, i8* (i64)*, void (i8*, i64)* }
%"class.std::type_info" = type { i32 (...)**, i8* }
%"struct.google::protobuf::internal::RepeatedPtrFieldBase::Rep" = type { i32, [1 x i8*] }
%"class.examples::grpc_server::Screen" = type <{ %"class.google::protobuf::Message", %"class.google::protobuf::internal::InternalMetadataWithArena", %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::CachedSize", %"class.google::protobuf::RepeatedPtrField.70", i32, i32, i32, i32, i32, [4 x i8] }>
%"class.google::protobuf::RepeatedPtrField.70" = type { %"class.google::protobuf::internal::RepeatedPtrFieldBase" }
%"class.examples::grpc_server::EnclaveOutput" = type { %"class.google::protobuf::Message", %"class.google::protobuf::internal::InternalMetadataWithArena", %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::CachedSize", %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::ReturnValue"* }
%"class.examples::grpc_server::ReturnValue" = type <{ %"class.google::protobuf::Message", %"class.google::protobuf::internal::InternalMetadataWithArena", %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::CachedSize", i32, [4 x i8] }>

$_ZNK8examples11grpc_server12EnclaveInput8snake_inEv = comdat any

$_ZNK8examples11grpc_server12EnclaveInput9screen_inEv = comdat any

$_ZN8examples11grpc_server13EnclaveOutput17mutable_snake_outEv = comdat any

$_ZN8examples11grpc_server13EnclaveOutput18mutable_screen_outEv = comdat any

$_ZN8examples11grpc_server13EnclaveOutput11mutable_retEv = comdat any

$_ZN8examples11grpc_server11ReturnValue12set_eat_goldEi = comdat any

$_ZN4grpc6StatusC2ERKS0_ = comdat any

$_ZN8examples11grpc_server11SnakeServerD2Ev = comdat any

$_ZN8examples11grpc_server11SnakeServerD0Ev = comdat any

$_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server5SnakeEEEPT_PNS0_5ArenaE = comdat any

$_ZNK8examples11grpc_server13EnclaveOutput17GetArenaNoVirtualEv = comdat any

$_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server6ScreenEEEPT_PNS0_5ArenaE = comdat any

$_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server11ReturnValueEEEPT_PNS0_5ArenaE = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZTVN8examples11grpc_server11SnakeServerE = unnamed_addr constant { [5 x i8*] } { [5 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTIN8examples11grpc_server11SnakeServerE to i8*), i8* bitcast (void (%"class.examples::grpc_server::SnakeServer"*)* @_ZN8examples11grpc_server11SnakeServerD2Ev to i8*), i8* bitcast (void (%"class.examples::grpc_server::SnakeServer"*)* @_ZN8examples11grpc_server11SnakeServerD0Ev to i8*), i8* bitcast (void (%"class.grpc::Status"*, %"class.examples::grpc_server::SnakeServer"*, %"class.grpc::ServerContext"*, %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveOutput"*)* @_ZN8examples11grpc_server11SnakeServer7EatGoldEPN4grpc13ServerContextEPKNS0_12EnclaveInputEPNS0_13EnclaveOutputE to i8*)] }, align 8
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [9 x i8] c"EatGold\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Gold Left \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"blah\0A\00", align 1
@_ZN4grpc6Status2OKE = external constant %"class.grpc::Status"*, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTSN8examples11grpc_server11SnakeServerE = constant [38 x i8] c"N8examples11grpc_server11SnakeServerE\00"
@_ZTIN8examples11grpc_server12SnakeService7ServiceE = external constant i8*
@_ZTIN8examples11grpc_server11SnakeServerE = constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @_ZTSN8examples11grpc_server11SnakeServerE, i32 0, i32 0), i8* bitcast (i8** @_ZTIN8examples11grpc_server12SnakeService7ServiceE to i8*) }
@_ZN8examples11grpc_server24_Snake_default_instance_E = external global %"class.examples::grpc_server::SnakeDefaultTypeInternal", align 1
@_ZN8examples11grpc_server25_Screen_default_instance_E = external global %"class.examples::grpc_server::ScreenDefaultTypeInternal", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_snake_server.cc, i8* null }]

@_ZN8examples11grpc_server11SnakeServerC1Ev = alias void (%"class.examples::grpc_server::SnakeServer"*), void (%"class.examples::grpc_server::SnakeServer"*)* @_ZN8examples11grpc_server11SnakeServerC2Ev

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: noinline optnone uwtable
define void @_ZN8examples11grpc_server11SnakeServerC2Ev(%"class.examples::grpc_server::SnakeServer"*) unnamed_addr #4 align 2 {
  %2 = alloca %"class.examples::grpc_server::SnakeServer"*, align 8
  store %"class.examples::grpc_server::SnakeServer"* %0, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  %3 = load %"class.examples::grpc_server::SnakeServer"*, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  %4 = bitcast %"class.examples::grpc_server::SnakeServer"* %3 to %"class.examples::grpc_server::SnakeService::Service"*
  call void @_ZN8examples11grpc_server12SnakeService7ServiceC2Ev(%"class.examples::grpc_server::SnakeService::Service"* %4)
  %5 = bitcast %"class.examples::grpc_server::SnakeServer"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [5 x i8*] }, { [5 x i8*] }* @_ZTVN8examples11grpc_server11SnakeServerE, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %5, align 8
  %6 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %3, i32 0, i32 1
  %7 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %3, i32 0, i32 2
  ret void
}

declare void @_ZN8examples11grpc_server12SnakeService7ServiceC2Ev(%"class.examples::grpc_server::SnakeService::Service"*) unnamed_addr #1

; Function Attrs: noinline optnone uwtable
define void @_ZN8examples11grpc_server11SnakeServer7EatGoldEPN4grpc13ServerContextEPKNS0_12EnclaveInputEPNS0_13EnclaveOutputE(%"class.grpc::Status"* noalias sret, %"class.examples::grpc_server::SnakeServer"*, %"class.grpc::ServerContext"*, %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveOutput"*) unnamed_addr #4 align 2 {
  %6 = alloca %"class.examples::grpc_server::SnakeServer"*, align 8
  %7 = alloca %"class.grpc::ServerContext"*, align 8
  %8 = alloca %"class.examples::grpc_server::EnclaveInput"*, align 8
  %9 = alloca %"class.examples::grpc_server::EnclaveOutput"*, align 8
  %10 = alloca %"class.examples::grpc_server::Snake"*, align 8
  %11 = alloca %"class.examples::grpc_server::Screen"*, align 8
  %12 = alloca %"class.examples::grpc_server::ReturnValue"*, align 8
  store %"class.examples::grpc_server::SnakeServer"* %1, %"class.examples::grpc_server::SnakeServer"** %6, align 8
  store %"class.grpc::ServerContext"* %2, %"class.grpc::ServerContext"** %7, align 8
  store %"class.examples::grpc_server::EnclaveInput"* %3, %"class.examples::grpc_server::EnclaveInput"** %8, align 8
  store %"class.examples::grpc_server::EnclaveOutput"* %4, %"class.examples::grpc_server::EnclaveOutput"** %9, align 8
  %13 = load %"class.examples::grpc_server::SnakeServer"*, %"class.examples::grpc_server::SnakeServer"** %6, align 8
  %14 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) @_ZSt4cout, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0))
  %15 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 1
  %16 = load %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveInput"** %8, align 8
  %17 = call dereferenceable(64) %"class.examples::grpc_server::Snake"* @_ZNK8examples11grpc_server12EnclaveInput8snake_inEv(%"class.examples::grpc_server::EnclaveInput"* %16)
  call void @_Z11createSnakeP7snake_tPKN8examples11grpc_server5SnakeE(%struct.snake_t* %15, %"class.examples::grpc_server::Snake"* %17)
  %18 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 2
  %19 = load %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveInput"** %8, align 8
  %20 = call dereferenceable(72) %"class.examples::grpc_server::Screen"* @_ZNK8examples11grpc_server12EnclaveInput9screen_inEv(%"class.examples::grpc_server::EnclaveInput"* %19)
  call void @_Z12createScreenP8screen_tPKN8examples11grpc_server6ScreenE(%struct.screen_t* %18, %"class.examples::grpc_server::Screen"* %20)
  %21 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 1
  %22 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 2
  %23 = call i32 @_Z8eat_goldP7snake_tP8screen_t(%struct.snake_t* %21, %struct.screen_t* %22)
  %24 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %9, align 8
  %25 = call %"class.examples::grpc_server::Snake"* @_ZN8examples11grpc_server13EnclaveOutput17mutable_snake_outEv(%"class.examples::grpc_server::EnclaveOutput"* %24)
  store %"class.examples::grpc_server::Snake"* %25, %"class.examples::grpc_server::Snake"** %10, align 8
  %26 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 1
  %27 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %10, align 8
  call void @_Z16createAsyloSnakeP7snake_tPN8examples11grpc_server5SnakeE(%struct.snake_t* %26, %"class.examples::grpc_server::Snake"* %27)
  %28 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %9, align 8
  %29 = call %"class.examples::grpc_server::Screen"* @_ZN8examples11grpc_server13EnclaveOutput18mutable_screen_outEv(%"class.examples::grpc_server::EnclaveOutput"* %28)
  store %"class.examples::grpc_server::Screen"* %29, %"class.examples::grpc_server::Screen"** %11, align 8
  %30 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 2
  %31 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %11, align 8
  call void @_Z17createAsyloScreenP8screen_tPN8examples11grpc_server6ScreenE(%struct.screen_t* %30, %"class.examples::grpc_server::Screen"* %31)
  %32 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %9, align 8
  %33 = call %"class.examples::grpc_server::ReturnValue"* @_ZN8examples11grpc_server13EnclaveOutput11mutable_retEv(%"class.examples::grpc_server::EnclaveOutput"* %32)
  store %"class.examples::grpc_server::ReturnValue"* %33, %"class.examples::grpc_server::ReturnValue"** %12, align 8
  %34 = load %"class.examples::grpc_server::ReturnValue"*, %"class.examples::grpc_server::ReturnValue"** %12, align 8
  %35 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 2
  %36 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %35, i32 0, i32 3
  %37 = load i32, i32* %36, align 4
  call void @_ZN8examples11grpc_server11ReturnValue12set_eat_goldEi(%"class.examples::grpc_server::ReturnValue"* %34, i32 %37)
  %38 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) @_ZSt4cout, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  %39 = getelementptr inbounds %"class.examples::grpc_server::SnakeServer", %"class.examples::grpc_server::SnakeServer"* %13, i32 0, i32 2
  %40 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %39, i32 0, i32 3
  %41 = load i32, i32* %40, align 4
  %42 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* %38, i32 %41)
  %43 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %42, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i32 0, i32 0))
  %45 = load %"class.grpc::Status"*, %"class.grpc::Status"** @_ZN4grpc6Status2OKE, align 8
  call void @_ZN4grpc6StatusC2ERKS0_(%"class.grpc::Status"* %0, %"class.grpc::Status"* dereferenceable(72) %45)
  ret void
}

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272), i8*) #1

declare void @_Z11createSnakeP7snake_tPKN8examples11grpc_server5SnakeE(%struct.snake_t*, %"class.examples::grpc_server::Snake"*) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(64) %"class.examples::grpc_server::Snake"* @_ZNK8examples11grpc_server12EnclaveInput8snake_inEv(%"class.examples::grpc_server::EnclaveInput"*) #5 comdat align 2 {
  %2 = alloca %"class.examples::grpc_server::EnclaveInput"*, align 8
  %3 = alloca %"class.examples::grpc_server::Snake"*, align 8
  store %"class.examples::grpc_server::EnclaveInput"* %0, %"class.examples::grpc_server::EnclaveInput"** %2, align 8
  %4 = load %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveInput"** %2, align 8
  %5 = getelementptr inbounds %"class.examples::grpc_server::EnclaveInput", %"class.examples::grpc_server::EnclaveInput"* %4, i32 0, i32 4
  %6 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %5, align 8
  store %"class.examples::grpc_server::Snake"* %6, %"class.examples::grpc_server::Snake"** %3, align 8
  %7 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %3, align 8
  %8 = icmp ne %"class.examples::grpc_server::Snake"* %7, null
  br i1 %8, label %9, label %11

; <label>:9:                                      ; preds = %1
  %10 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %3, align 8
  br label %12

; <label>:11:                                     ; preds = %1
  br label %12

; <label>:12:                                     ; preds = %11, %9
  %13 = phi %"class.examples::grpc_server::Snake"* [ %10, %9 ], [ bitcast (%"class.examples::grpc_server::SnakeDefaultTypeInternal"* @_ZN8examples11grpc_server24_Snake_default_instance_E to %"class.examples::grpc_server::Snake"*), %11 ]
  ret %"class.examples::grpc_server::Snake"* %13
}

declare void @_Z12createScreenP8screen_tPKN8examples11grpc_server6ScreenE(%struct.screen_t*, %"class.examples::grpc_server::Screen"*) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(72) %"class.examples::grpc_server::Screen"* @_ZNK8examples11grpc_server12EnclaveInput9screen_inEv(%"class.examples::grpc_server::EnclaveInput"*) #5 comdat align 2 {
  %2 = alloca %"class.examples::grpc_server::EnclaveInput"*, align 8
  %3 = alloca %"class.examples::grpc_server::Screen"*, align 8
  store %"class.examples::grpc_server::EnclaveInput"* %0, %"class.examples::grpc_server::EnclaveInput"** %2, align 8
  %4 = load %"class.examples::grpc_server::EnclaveInput"*, %"class.examples::grpc_server::EnclaveInput"** %2, align 8
  %5 = getelementptr inbounds %"class.examples::grpc_server::EnclaveInput", %"class.examples::grpc_server::EnclaveInput"* %4, i32 0, i32 5
  %6 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %5, align 8
  store %"class.examples::grpc_server::Screen"* %6, %"class.examples::grpc_server::Screen"** %3, align 8
  %7 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %3, align 8
  %8 = icmp ne %"class.examples::grpc_server::Screen"* %7, null
  br i1 %8, label %9, label %11

; <label>:9:                                      ; preds = %1
  %10 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %3, align 8
  br label %12

; <label>:11:                                     ; preds = %1
  br label %12

; <label>:12:                                     ; preds = %11, %9
  %13 = phi %"class.examples::grpc_server::Screen"* [ %10, %9 ], [ bitcast (%"class.examples::grpc_server::ScreenDefaultTypeInternal"* @_ZN8examples11grpc_server25_Screen_default_instance_E to %"class.examples::grpc_server::Screen"*), %11 ]
  ret %"class.examples::grpc_server::Screen"* %13
}

declare i32 @_Z8eat_goldP7snake_tP8screen_t(%struct.snake_t*, %struct.screen_t*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::Snake"* @_ZN8examples11grpc_server13EnclaveOutput17mutable_snake_outEv(%"class.examples::grpc_server::EnclaveOutput"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::internal::HasBits"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %"class.examples::grpc_server::EnclaveOutput"*, align 8
  %5 = alloca %"class.examples::grpc_server::Snake"*, align 8
  store %"class.examples::grpc_server::EnclaveOutput"* %0, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %6 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %7 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 2
  store %"class.google::protobuf::internal::HasBits"* %7, %"class.google::protobuf::internal::HasBits"** %2, align 8
  store i32 0, i32* %3, align 4
  %8 = load %"class.google::protobuf::internal::HasBits"*, %"class.google::protobuf::internal::HasBits"** %2, align 8
  %9 = getelementptr inbounds %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::HasBits"* %8, i32 0, i32 0
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1 x i32], [1 x i32]* %9, i64 0, i64 %11
  %13 = load i32, i32* %12, align 4
  %14 = or i32 %13, 1
  store i32 %14, i32* %12, align 4
  %15 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 4
  %16 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %15, align 8
  %17 = icmp eq %"class.examples::grpc_server::Snake"* %16, null
  br i1 %17, label %18, label %23

; <label>:18:                                     ; preds = %1
  %19 = call %"class.google::protobuf::Arena"* @_ZNK8examples11grpc_server13EnclaveOutput17GetArenaNoVirtualEv(%"class.examples::grpc_server::EnclaveOutput"* %6)
  %20 = call %"class.examples::grpc_server::Snake"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server5SnakeEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"* %19)
  store %"class.examples::grpc_server::Snake"* %20, %"class.examples::grpc_server::Snake"** %5, align 8
  %21 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %5, align 8
  %22 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 4
  store %"class.examples::grpc_server::Snake"* %21, %"class.examples::grpc_server::Snake"** %22, align 8
  br label %23

; <label>:23:                                     ; preds = %18, %1
  %24 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 4
  %25 = load %"class.examples::grpc_server::Snake"*, %"class.examples::grpc_server::Snake"** %24, align 8
  ret %"class.examples::grpc_server::Snake"* %25
}

declare void @_Z16createAsyloSnakeP7snake_tPN8examples11grpc_server5SnakeE(%struct.snake_t*, %"class.examples::grpc_server::Snake"*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::Screen"* @_ZN8examples11grpc_server13EnclaveOutput18mutable_screen_outEv(%"class.examples::grpc_server::EnclaveOutput"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::internal::HasBits"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %"class.examples::grpc_server::EnclaveOutput"*, align 8
  %5 = alloca %"class.examples::grpc_server::Screen"*, align 8
  store %"class.examples::grpc_server::EnclaveOutput"* %0, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %6 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %7 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 2
  store %"class.google::protobuf::internal::HasBits"* %7, %"class.google::protobuf::internal::HasBits"** %2, align 8
  store i32 0, i32* %3, align 4
  %8 = load %"class.google::protobuf::internal::HasBits"*, %"class.google::protobuf::internal::HasBits"** %2, align 8
  %9 = getelementptr inbounds %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::HasBits"* %8, i32 0, i32 0
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1 x i32], [1 x i32]* %9, i64 0, i64 %11
  %13 = load i32, i32* %12, align 4
  %14 = or i32 %13, 2
  store i32 %14, i32* %12, align 4
  %15 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 5
  %16 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %15, align 8
  %17 = icmp eq %"class.examples::grpc_server::Screen"* %16, null
  br i1 %17, label %18, label %23

; <label>:18:                                     ; preds = %1
  %19 = call %"class.google::protobuf::Arena"* @_ZNK8examples11grpc_server13EnclaveOutput17GetArenaNoVirtualEv(%"class.examples::grpc_server::EnclaveOutput"* %6)
  %20 = call %"class.examples::grpc_server::Screen"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server6ScreenEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"* %19)
  store %"class.examples::grpc_server::Screen"* %20, %"class.examples::grpc_server::Screen"** %5, align 8
  %21 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %5, align 8
  %22 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 5
  store %"class.examples::grpc_server::Screen"* %21, %"class.examples::grpc_server::Screen"** %22, align 8
  br label %23

; <label>:23:                                     ; preds = %18, %1
  %24 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 5
  %25 = load %"class.examples::grpc_server::Screen"*, %"class.examples::grpc_server::Screen"** %24, align 8
  ret %"class.examples::grpc_server::Screen"* %25
}

declare void @_Z17createAsyloScreenP8screen_tPN8examples11grpc_server6ScreenE(%struct.screen_t*, %"class.examples::grpc_server::Screen"*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::ReturnValue"* @_ZN8examples11grpc_server13EnclaveOutput11mutable_retEv(%"class.examples::grpc_server::EnclaveOutput"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::internal::HasBits"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %"class.examples::grpc_server::EnclaveOutput"*, align 8
  %5 = alloca %"class.examples::grpc_server::ReturnValue"*, align 8
  store %"class.examples::grpc_server::EnclaveOutput"* %0, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %6 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %4, align 8
  %7 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 2
  store %"class.google::protobuf::internal::HasBits"* %7, %"class.google::protobuf::internal::HasBits"** %2, align 8
  store i32 0, i32* %3, align 4
  %8 = load %"class.google::protobuf::internal::HasBits"*, %"class.google::protobuf::internal::HasBits"** %2, align 8
  %9 = getelementptr inbounds %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::HasBits"* %8, i32 0, i32 0
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1 x i32], [1 x i32]* %9, i64 0, i64 %11
  %13 = load i32, i32* %12, align 4
  %14 = or i32 %13, 4
  store i32 %14, i32* %12, align 4
  %15 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 6
  %16 = load %"class.examples::grpc_server::ReturnValue"*, %"class.examples::grpc_server::ReturnValue"** %15, align 8
  %17 = icmp eq %"class.examples::grpc_server::ReturnValue"* %16, null
  br i1 %17, label %18, label %23

; <label>:18:                                     ; preds = %1
  %19 = call %"class.google::protobuf::Arena"* @_ZNK8examples11grpc_server13EnclaveOutput17GetArenaNoVirtualEv(%"class.examples::grpc_server::EnclaveOutput"* %6)
  %20 = call %"class.examples::grpc_server::ReturnValue"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server11ReturnValueEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"* %19)
  store %"class.examples::grpc_server::ReturnValue"* %20, %"class.examples::grpc_server::ReturnValue"** %5, align 8
  %21 = load %"class.examples::grpc_server::ReturnValue"*, %"class.examples::grpc_server::ReturnValue"** %5, align 8
  %22 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 6
  store %"class.examples::grpc_server::ReturnValue"* %21, %"class.examples::grpc_server::ReturnValue"** %22, align 8
  br label %23

; <label>:23:                                     ; preds = %18, %1
  %24 = getelementptr inbounds %"class.examples::grpc_server::EnclaveOutput", %"class.examples::grpc_server::EnclaveOutput"* %6, i32 0, i32 6
  %25 = load %"class.examples::grpc_server::ReturnValue"*, %"class.examples::grpc_server::ReturnValue"** %24, align 8
  ret %"class.examples::grpc_server::ReturnValue"* %25
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN8examples11grpc_server11ReturnValue12set_eat_goldEi(%"class.examples::grpc_server::ReturnValue"*, i32) #5 comdat align 2 {
  %3 = alloca %"class.google::protobuf::internal::HasBits"*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %"class.examples::grpc_server::ReturnValue"*, align 8
  %6 = alloca i32, align 4
  store %"class.examples::grpc_server::ReturnValue"* %0, %"class.examples::grpc_server::ReturnValue"** %5, align 8
  store i32 %1, i32* %6, align 4
  %7 = load %"class.examples::grpc_server::ReturnValue"*, %"class.examples::grpc_server::ReturnValue"** %5, align 8
  %8 = getelementptr inbounds %"class.examples::grpc_server::ReturnValue", %"class.examples::grpc_server::ReturnValue"* %7, i32 0, i32 2
  store %"class.google::protobuf::internal::HasBits"* %8, %"class.google::protobuf::internal::HasBits"** %3, align 8
  store i32 0, i32* %4, align 4
  %9 = load %"class.google::protobuf::internal::HasBits"*, %"class.google::protobuf::internal::HasBits"** %3, align 8
  %10 = getelementptr inbounds %"class.google::protobuf::internal::HasBits", %"class.google::protobuf::internal::HasBits"* %9, i32 0, i32 0
  %11 = load i32, i32* %4, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [1 x i32], [1 x i32]* %10, i64 0, i64 %12
  %14 = load i32, i32* %13, align 4
  %15 = or i32 %14, 1
  store i32 %15, i32* %13, align 4
  %16 = load i32, i32* %6, align 4
  %17 = getelementptr inbounds %"class.examples::grpc_server::ReturnValue", %"class.examples::grpc_server::ReturnValue"* %7, i32 0, i32 4
  store i32 %16, i32* %17, align 8
  ret void
}

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4grpc6StatusC2ERKS0_(%"class.grpc::Status"*, %"class.grpc::Status"* dereferenceable(72)) unnamed_addr #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.grpc::Status"*, align 8
  %4 = alloca %"class.grpc::Status"*, align 8
  %5 = alloca i8*
  %6 = alloca i32
  store %"class.grpc::Status"* %0, %"class.grpc::Status"** %3, align 8
  store %"class.grpc::Status"* %1, %"class.grpc::Status"** %4, align 8
  %7 = load %"class.grpc::Status"*, %"class.grpc::Status"** %3, align 8
  %8 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %7, i32 0, i32 0
  %9 = load %"class.grpc::Status"*, %"class.grpc::Status"** %4, align 8
  %10 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  store i32 %11, i32* %8, align 8
  %12 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %7, i32 0, i32 1
  %13 = load %"class.grpc::Status"*, %"class.grpc::Status"** %4, align 8
  %14 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %13, i32 0, i32 1
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* %12, %"class.std::__cxx11::basic_string"* dereferenceable(32) %14)
  %15 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %7, i32 0, i32 2
  %16 = load %"class.grpc::Status"*, %"class.grpc::Status"** %4, align 8
  %17 = getelementptr inbounds %"class.grpc::Status", %"class.grpc::Status"* %16, i32 0, i32 2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* %15, %"class.std::__cxx11::basic_string"* dereferenceable(32) %17)
          to label %18 unwind label %19

; <label>:18:                                     ; preds = %2
  ret void

; <label>:19:                                     ; preds = %2
  %20 = landingpad { i8*, i32 }
          cleanup
  %21 = extractvalue { i8*, i32 } %20, 0
  store i8* %21, i8** %5, align 8
  %22 = extractvalue { i8*, i32 } %20, 1
  store i32 %22, i32* %6, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %12) #3
  br label %23

; <label>:23:                                     ; preds = %19
  %24 = load i8*, i8** %5, align 8
  %25 = load i32, i32* %6, align 4
  %26 = insertvalue { i8*, i32 } undef, i8* %24, 0
  %27 = insertvalue { i8*, i32 } %26, i32 %25, 1
  resume { i8*, i32 } %27
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN8examples11grpc_server11SnakeServerD2Ev(%"class.examples::grpc_server::SnakeServer"*) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.examples::grpc_server::SnakeServer"*, align 8
  store %"class.examples::grpc_server::SnakeServer"* %0, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  %3 = load %"class.examples::grpc_server::SnakeServer"*, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  %4 = bitcast %"class.examples::grpc_server::SnakeServer"* %3 to %"class.examples::grpc_server::SnakeService::Service"*
  call void @_ZN8examples11grpc_server12SnakeService7ServiceD2Ev(%"class.examples::grpc_server::SnakeService::Service"* %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN8examples11grpc_server11SnakeServerD0Ev(%"class.examples::grpc_server::SnakeServer"*) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.examples::grpc_server::SnakeServer"*, align 8
  store %"class.examples::grpc_server::SnakeServer"* %0, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  %3 = load %"class.examples::grpc_server::SnakeServer"*, %"class.examples::grpc_server::SnakeServer"** %2, align 8
  call void @_ZN8examples11grpc_server11SnakeServerD2Ev(%"class.examples::grpc_server::SnakeServer"* %3) #3
  %4 = bitcast %"class.examples::grpc_server::SnakeServer"* %3 to i8*
  call void @_ZdlPv(i8* %4) #7
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::Snake"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server5SnakeEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::Arena"*, align 8
  store %"class.google::protobuf::Arena"* %0, %"class.google::protobuf::Arena"** %2, align 8
  %3 = load %"class.google::protobuf::Arena"*, %"class.google::protobuf::Arena"** %2, align 8
  %4 = call %"class.examples::grpc_server::Snake"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server5SnakeEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"* %3)
  ret %"class.examples::grpc_server::Snake"* %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.google::protobuf::Arena"* @_ZNK8examples11grpc_server13EnclaveOutput17GetArenaNoVirtualEv(%"class.examples::grpc_server::EnclaveOutput"*) #5 comdat align 2 {
  %2 = alloca %"class.examples::grpc_server::EnclaveOutput"*, align 8
  store %"class.examples::grpc_server::EnclaveOutput"* %0, %"class.examples::grpc_server::EnclaveOutput"** %2, align 8
  %3 = load %"class.examples::grpc_server::EnclaveOutput"*, %"class.examples::grpc_server::EnclaveOutput"** %2, align 8
  ret %"class.google::protobuf::Arena"* null
}

declare %"class.examples::grpc_server::Snake"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server5SnakeEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::Screen"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server6ScreenEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::Arena"*, align 8
  store %"class.google::protobuf::Arena"* %0, %"class.google::protobuf::Arena"** %2, align 8
  %3 = load %"class.google::protobuf::Arena"*, %"class.google::protobuf::Arena"** %2, align 8
  %4 = call %"class.examples::grpc_server::Screen"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server6ScreenEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"* %3)
  ret %"class.examples::grpc_server::Screen"* %4
}

declare %"class.examples::grpc_server::Screen"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server6ScreenEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.examples::grpc_server::ReturnValue"* @_ZN6google8protobuf11MessageLite18CreateMaybeMessageIN8examples11grpc_server11ReturnValueEEEPT_PNS0_5ArenaE(%"class.google::protobuf::Arena"*) #4 comdat align 2 {
  %2 = alloca %"class.google::protobuf::Arena"*, align 8
  store %"class.google::protobuf::Arena"* %0, %"class.google::protobuf::Arena"** %2, align 8
  %3 = load %"class.google::protobuf::Arena"*, %"class.google::protobuf::Arena"** %2, align 8
  %4 = call %"class.examples::grpc_server::ReturnValue"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server11ReturnValueEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"* %3)
  ret %"class.examples::grpc_server::ReturnValue"* %4
}

declare %"class.examples::grpc_server::ReturnValue"* @_ZN6google8protobuf5Arena18CreateMaybeMessageIN8examples11grpc_server11ReturnValueEJEEEPT_PS1_DpOT0_(%"class.google::protobuf::Arena"*) #1

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"* dereferenceable(32)) unnamed_addr #1

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"*) unnamed_addr #2

; Function Attrs: nounwind
declare void @_ZN8examples11grpc_server12SnakeService7ServiceD2Ev(%"class.examples::grpc_server::SnakeService::Service"*) unnamed_addr #2

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #6

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_snake_server.cc() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nobuiltin nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.1-9.2 (tags/RELEASE_601/final)"}
