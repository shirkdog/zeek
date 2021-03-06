# @TEST-EXEC: zeek -b -C -r $TRACES/http/multipart.trace %INPUT
# @TEST-EXEC: btest-diff http.log
# @TEST-EXEC: cat extract_files/http-item-* | sort > extractions

@load base/protocols/http
@load base/files/extract

event file_new(f: fa_file)
	{
	local fname = fmt("http-item-%s", f$id);
	Files::add_analyzer(f, Files::ANALYZER_EXTRACT, [$extract_filename=fname]);
	}
